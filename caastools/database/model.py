TBL_SCRIPT = """
    CREATE TABLE IF NOT EXISTS CODING_SYSTEM (
        CODING_SYSTEM_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER UNIQUE,
        NAME VARCHAR2(255) NOT NULL UNIQUE,
        PATH VARCHAR2(32767) NOT NULL UNIQUE
    );
    CREATE TABLE IF NOT EXISTS INTERVIEW (
        INTERVIEW_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER UNIQUE,
        INTERVIEW_NAME VARCHAR2(100) NOT NULL,
        INTERVIEW_TYPE VARCHAR2(20) NOT NULL,
        CODING_SYSTEM_ID INTEGER NOT NULL,
        SESSION_NUMBER INTEGER NOT NULL DEFAULT 1,
        STUDY_ID INTEGER,
        CLIENT_ID VARCHAR2(100) NOT NULL,
        THERAPIST_ID INTEGER(100) NOT NULL,
        RATER_ID VARCHAR2(100) NOT NULL,
        LANGUAGE VARCHAR2(5) NOT NULL DEFAULT 'en',
        CONDITION INTEGER NOT NULL,
        FOREIGN KEY(CODING_SYSTEM_ID) REFERENCES CODING_SYSTEM(CODING_SYSTEM_ID) ON UPDATE CASCADE ON DELETE RESTRICT
        CONSTRAINT iv_nm_iv_tp_unique UNIQUE(interview_name, interview_type) 
    );
    CREATE TABLE IF NOT EXISTS CODING_PROPERTY (
        CODING_PROPERTY_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER,
        CODING_SYSTEM_ID INTEGER NOT NULL,
        NAME VARCHAR2(100) NOT NULL,
        DISPLAY_NAME VARCHAR2(10) NOT NULL,
        SORT_ORDER INTEGER NOT NULL DEFAULT 0,
        DATA_TYPE VARCHAR2(10) NOT NULL DEFAULT 'string',
        DECIMAL_DIGITS INTEGER NOT NULL DEFAULT 0,
        ZERO_PAD INTEGER NOT NULL DEFAULT 0,
        DESCRIPTION VARCHAR2(500) NOT NULL,
        VARIABLE_NAME VARCHAR2(20),
        FOREIGN KEY(CODING_SYSTEM_ID) REFERENCES CODING_SYSTEM(CODING_SYSTEM_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT cp_name_cs_id_unique UNIQUE(NAME, CODING_SYSTEM_ID),
        CONSTRAINT cp_name_cs_id_unique UNIQUE(DISPLAY_NAME,CODING_SYSTEM_ID),
        CONSTRAINT cp_source_id_cs_id_unique UNIQUE(source_id, coding_system_id),
        CONSTRAINT cp_data_type CHECK (DATA_TYPE IN ('string', 'numeric')),
        CONSTRAINT cp_var_name_chk CHECK (vn_validate(variable_name))
    );
    CREATE TABLE IF NOT EXISTS GLOBAL_PROPERTY (
        GLOBAL_PROPERTY_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER,
        CODING_SYSTEM_ID INTEGER NOT NULL,
        NAME VARCHAR2(100) NOT NULL,
        DISPLAY_NAME VARCHAR2(10) NOT NULL,
        DESCRIPTION VARCHAR2(500) NOT NULL,
        DATA_TYPE VARCHAR2(10) NOT NULL DEFAULT 'numeric',
        VARIABLE_NAME VARCHAR2(20),
        FOREIGN KEY(CODING_SYSTEM_ID) REFERENCES CODING_SYSTEM(CODING_SYSTEM_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT cp_data_type CHECK (DATA_TYPE IN ('string', 'numeric')),
        CONSTRAINT gp_source_id_cs_id_unique UNIQUE(source_id, coding_system_id),
        CONSTRAINT gp_name_cs_id_unique UNIQUE(name, coding_system_id),
        CONSTRAINT gp_var_name_chk CHECK (vn_validate(variable_name))
    );
    CREATE TABLE IF NOT EXISTS GLOBAL_VALUE (
        GLOBAL_VALUE_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER,
        GLOBAL_PROPERTY_ID INTEGER NOT NULL,
        VALUE VARCHAR2(50) NOT NULL,
        DESCRIPTION VARCHAR2(500) NOT NULL,
        FOREIGN KEY(GLOBAL_PROPERTY_ID) REFERENCES GLOBAL_PROPERTY(GLOBAL_PROPERTY_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT gv_value_gp_id_unique UNIQUE(value, global_property_id),
        CONSTRAINT gv_source_id_gp_id_unique UNIQUE(source_id, global_property_id)
    );
    CREATE TABLE IF NOT EXISTS PROPERTY_VALUE (
        PROPERTY_VALUE_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
        SOURCE_ID INTEGER,
        CODING_PROPERTY_ID INTEGER NOT NULL,
        VALUE VARCHAR2(50) NOT NULL,
        DESCRIPTION VARCHAR2(500) NOT NULL,
        VARIABLE_NAME VARCHAR2(32),
        FOREIGN KEY(CODING_PROPERTY_ID) REFERENCES CODING_PROPERTY(CODING_PROPERTY_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT pv_value_cp_id_unique UNIQUE(value, coding_property_id),
        CONSTRAINT pv_source_id_cp_id_unique UNIQUE(source_id, coding_property_id),
        CONSTRAINT pv_var_name_chk CHECK (vn_validate(variable_name))
    );
    CREATE TABLE IF NOT EXISTS UTTERANCE (
        UTTERANCE_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER,
        INTERVIEW_ID INTEGER NOT NULL,
        LINE_NUMBER INTEGER,
        UTT_NUMBER INTEGER NOT NULL,
        SPEAKER_ROLE VARCHAR2(5),
        UTT_TEXT VARCHAR2(32767),
        WORD_COUNT INTEGER,
        START_TIME REAL,
        END_TIME REAL,
        FOREIGN KEY(INTERVIEW_ID) REFERENCES INTERVIEW(INTERVIEW_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT utt_enum_iv_id_unique UNIQUE (UTT_NUMBER, interview_id),
        CONSTRAINT source_id_iv_id_unique UNIQUE (source_id, interview_id)
    );
    CREATE TABLE IF NOT EXISTS UTTERANCE_CODE(
        UTTERANCE_CODE_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER,
        UTTERANCE_ID INTEGER NOT NULL,
        PROPERTY_VALUE_ID INTEGER NOT NULL,
        FOREIGN KEY(UTTERANCE_ID) REFERENCES UTTERANCE(UTTERANCE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY(PROPERTY_VALUE_ID) REFERENCES PROPERTY_VALUE(PROPERTY_VALUE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT utt_id_pv_iq_unique UNIQUE(utterance_id, property_value_id)
    );
    CREATE TABLE IF NOT EXISTS GLOBAL_RATING (
        GLOBAL_RATING_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SOURCE_ID INTEGER,
        INTERVIEW_ID INTEGER NOT NULL,
        GLOBAL_VALUE_ID INTEGER NOT NULL,
        FOREIGN KEY(INTERVIEW_ID) REFERENCES INTERVIEW(INTERVIEW_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY(GLOBAL_VALUE_ID) REFERENCES GLOBAL_VALUE(GLOBAL_VALUE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT gv_id_iv_id_unique UNIQUE (global_value_id, interview_id)
    );
    CREATE TABLE IF NOT EXISTS SUMMARY_VARIABLE (
        SUMMARY_VARIABLE_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        CODING_SYSTEM_ID INTEGER NOT NULL,
        VARIABLE_NAME VARCHAR2(32) NOT NULL,
        VARIABLE_LABEL VARCHAR2(128),
        PARENT_TABLE_NAME VARCHAR2(100) NOT NULL,
        SUMMARY_FUNC VARCHAR2(100) NOT NULL DEFAULT 'sum',
        FOREIGN KEY (CODING_SYSTEM_ID) REFERENCES CODING_SYSTEM(CODING_SYSTEM_ID) ON UPDATE CASCADE ON DELETE CASCADE,
        CONSTRAINT sv_ptbl_nm CHECK (LOWER(PARENT_TABLE_NAME) IN ('property_value', 'global_property')),
        CONSTRAINT sv_sum_func CHECK (LOWER(SUMMARY_FUNC) IN ('sum', 'mean')),
        CONSTRAINT sv_var_name_chk CHECK (vn_validate(variable_name))
        CONSTRAINT sv_csid_vn_unique UNIQUE (coding_system_id, variable_name)
    );
    CREATE TABLE IF NOT EXISTS SUMMARY_VARIABLE_LINK (
        SUMMARY_VARIABLE_LINK_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        SUMMARY_VARIABLE_ID INTEGER NOT NULL,
        PARENT_PRIMARY_KEY INTEGER NOT NULL,
        FOREIGN KEY (SUMMARY_VARIABLE_ID) REFERENCES SUMMARY_VARIABLE(SUMMARY_VARIABLE_ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
    CREATE TABLE IF NOT EXISTS UTTERANCE_STAGING (
        INTERVIEW_NAME VARCHAR2(100) NOT NULL,
        INTERVIEW_TYPE VARCHAR2(20) NOT NULL,
        CS_NAME VARCHAR2(255) NOT NULL,
        CP_NAME VARCHAR2(100) NOT NULL,
        LINE_NUMBER INTEGER,
        UTT_NUMBER INTEGER NOT NULL,
        SPEAKER_ROLE VARCHAR2(5),
        UTT_TEXT VARCHAR2(32767),
        START_TIME REAL,
        END_TIME REAL,
        PV_VALUE VARCHAR2(50)
    );
    CREATE TABLE IF NOT EXISTS GLOBAL_STAGING (
        INTERVIEW_NAME VARCHAR2(100) NOT NULL,
        INTERVIEW_TYPE VARCHAR2(20) NOT NULL,
        CS_NAME VARCHAR2(255) NOT NULL,
        GP_NAME VARCHAR2(100) NOT NULL,
        GV_VALUE VARCHAR2(50) NOT NULL
    );
    CREATE TABLE IF NOT EXISTS SUMMARY_STAGING (
        CODING_SYSTEM_NAME VARCHAR2(255) NOT NULL
        PARENT_TABLE_NAME VARCHAR2(255) NOT NULL,
        PARENT_VALUE_NAME VARCHAR2(255),
        PARENT_PROPERTY_NAME VARCHAR2(255)
    );
    CREATE INDEX IF NOT EXISTS XFKINTERVIEW ON INTERVIEW(CODING_SYSTEM_ID);
    CREATE INDEX IF NOT EXISTS XNMINTERVIEW ON INTERVIEW(INTERVIEW_NAME);
    CREATE INDEX IF NOT EXISTS XCIDINTERVIEW ON INTERVIEW(CLIENT_ID);
    CREATE INDEX IF NOT EXISTS XTXIDINTERVIEW ON INTERVIEW(THERAPIST_ID);
    
    CREATE INDEX IF NOT EXISTS XNMCODINGSYSTEM ON CODING_SYSTEM(NAME);
    
    CREATE INDEX IF NOT EXISTS XSRCIDCODINGPROPERTY ON CODING_PROPERTY(SOURCE_ID);
    CREATE INDEX IF NOT EXISTS XNMCODINGPROPERTY ON CODING_PROPERTY(NAME); 
    CREATE INDEX IF NOT EXISTS XDSPNMCODINGPROPERTY ON CODING_PROPERTY(DISPLAY_NAME); 
    CREATE INDEX IF NOT EXISTS XFKCODINGPROPERTY ON CODING_PROPERTY(CODING_SYSTEM_ID);
    
    CREATE INDEX IF NOT EXISTS XSRCIDGLOBALPROPERTY ON GLOBAL_PROPERTY(SOURCE_ID);
    CREATE INDEX IF NOT EXISTS XNMGLOBALPROPERTY ON GLOBAL_PROPERTY(NAME); 
    CREATE INDEX IF NOT EXISTS XDSPNMGLOBALPROPERTY ON GLOBAL_PROPERTY(DISPLAY_NAME); 
    CREATE INDEX IF NOT EXISTS XFKGLOBALPROPERTY ON GLOBAL_PROPERTY(CODING_SYSTEM_ID); 
    
    CREATE INDEX IF NOT EXISTS XSRCIDGLOBALVALUE ON GLOBAL_VALUE(SOURCE_ID);
    CREATE INDEX IF NOT EXISTS XVALGLOBALVALUE ON GLOBAL_VALUE(VALUE);
    CREATE INDEX IF NOT EXISTS XFKGLOBALVALUE ON GLOBAL_VALUE(GLOBAL_PROPERTY_ID);
    
    CREATE INDEX IF NOT EXISTS XSRCIDPROPVALUE ON PROPERTY_VALUE(SOURCE_ID);
    CREATE INDEX IF NOT EXISTS XVALPROPVALUE ON PROPERTY_VALUE(VALUE);
    CREATE INDEX IF NOT EXISTS XFKPROPVALUE ON PROPERTY_VALUE(CODING_PROPERTY_ID);
    
    CREATE INDEX IF NOT EXISTS XSRCIDUTTERANCE ON UTTERANCE(SOURCE_ID);
    CREATE INDEX IF NOT EXISTS XUTTNUMUTTERANCE ON UTTERANCE(UTT_NUMBER);
    CREATE INDEX IF NOT EXISTS XLINEUTTERANCE ON UTTERANCE(LINE_NUMBER);
    CREATE INDEX IF NOT EXISTS XROLEUTTERANCE ON UTTERANCE(SPEAKER_ROLE);
    CREATE INDEX IF NOT EXISTS XFKUTTERANCE ON UTTERANCE(INTERVIEW_ID);
    
    CREATE INDEX IF NOT EXISTS XSRCIDUTTCODE ON UTTERANCE_CODE(SOURCE_ID);
    CREATE INDEX IF NOT EXISTS XFK1UTTCODE ON UTTERANCE_CODE(UTTERANCE_ID);
    CREATE INDEX IF NOT EXISTS XFK2UTTCODE ON UTTERANCE_CODE(PROPERTY_VALUE_ID);
    
    CREATE INDEX IF NOT EXISTS XSRCIDGLBRAT ON GLOBAL_RATING(SOURCE_ID);
    CREATE INDEX IF NOT EXISTS XFK1GLBRAT ON GLOBAL_RATING(INTERVIEW_ID);
    CREATE INDEX IF NOT EXISTS XFK2GLBRAT ON GLOBAL_RATING(GLOBAL_VALUE_ID);
    
    CREATE INDEX IF NOT EXISTS XSVCSID ON SUMMARY_VARIABLE (CODING_SYSTEM_ID);
    CREATE INDEX IF NOT EXISTS XSVVNM ON SUMMARY_VARIABLE (VARIABLE_NAME);
    CREATE INDEX IF NOT EXISTS XSVPTN ON SUMMARY_VARIABLE (PARENT_TABLE_NAME);
    
    CREATE INDEX IF NOT EXISTS XSVLPPK ON SUMMARY_VARIABLE_LINK (PARENT_PRIMARY_KEY);
    CREATE INDEX IF NOT EXISTS XFKSVL ON SUMMARY_VARIABLE_LINK (SUMMARY_VARIABLE_ID);
    
    CREATE INDEX IF NOT EXISTS XIVNMUTTSTG ON UTTERANCE_STAGING(INTERVIEW_NAME);
    CREATE INDEX IF NOT EXISTS XIVTPUTTSTG ON UTTERANCE_STAGING(INTERVIEW_TYPE);
    CREATE INDEX IF NOT EXISTS XCSNMUTTSTG ON UTTERANCE_STAGING(CS_NAME);
    CREATE INDEX IF NOT EXISTS XCPNMUTTSTG ON UTTERANCE_STAGING(CP_NAME);
    CREATE INDEX IF NOT EXISTS XUTTLNUTTSTG ON UTTERANCE_STAGING(LINE_NUMBER);
    CREATE INDEX IF NOT EXISTS XUTTNMUTTSTG ON UTTERANCE_STAGING(UTT_NUMBER);
    CREATE INDEX IF NOT EXISTS XUTTRLUTTSTG ON UTTERANCE_STAGING(SPEAKER_ROLE);
    CREATE INDEX IF NOT EXISTS XPVALUTTSTG ON UTTERANCE_STAGING(PV_VALUE);
    
    CREATE INDEX IF NOT EXISTS XIVNMGLBSTG ON GLOBAL_STAGING(INTERVIEW_NAME);
    CREATE INDEX IF NOT EXISTS XIVTPMGLBSTG ON GLOBAL_STAGING(INTERVIEW_TYPE);
    CREATE INDEX IF NOT EXISTS XCSNMGLBSTG ON GLOBAL_STAGING(CS_NAME);
    CREATE INDEX IF NOT EXISTS XGPNMGLBSTG ON GLOBAL_STAGING(GP_NAME);
    CREATE INDEX IF NOT EXISTS XGVALGLBSTG ON GLOBAL_STAGING(GV_VALUE);
    
    CREATE TRIGGER IF NOT EXISTS XCPVARNM AFTER INSERT ON CODING_PROPERTY WHEN NEW.VARIABLE_NAME IS NULL
    BEGIN
        UPDATE coding_property 
        SET VARIABLE_NAME = 'CPVAR_' || new.coding_property_id 
        WHERE CODING_PROPERTY_ID = new.coding_property_id;
    END;
    
    CREATE TRIGGER IF NOT EXISTS XGPVARNM AFTER INSERT ON GLOBAL_PROPERTY WHEN NEW.VARIABLE_NAME IS NULL
    BEGIN
        UPDATE global_property 
        SET variable_name = 'GPVAR_' || new.global_property_id 
        WHERE global_property_id = new.global_property_id;
    END;
    
    CREATE TRIGGER IF NOT EXISTS XPVVARNM AFTER INSERT ON PROPERTY_VALUE WHEN NEW.VARIABLE_NAME IS NULL
    BEGIN
        UPDATE property_value 
        SET variable_name = (SELECT variable_name FROM coding_property WHERE coding_property_id = new.coding_property_id) || '_' || new.property_value_id
        WHERE property_value_id = new.property_value_id;
    END;
    CREATE VIEW IF NOT EXISTS SEQUENTIAL_DATASET(utterance_id, interview_name, interview_type, rater_id, client_id,
            session_number, language, condition, line_number, utt_number, speaker_role, variable_name, data_type,
            value, utt_text, start_time, end_time) AS 
        SELECT 
        utterance.utterance_id,
        interview.interview_name, 
        interview.interview_type, 
        interview.rater_id, 
        interview.client_id, 
        interview.session_number, 
        interview.language,
        interview.condition,
        utterance.line_number, 
        utterance.utt_number, 
        utterance.speaker_role, 
        coding_property.variable_name,
        coding_property.data_type, 
        property_value.value, 
        utterance.utt_text, 
        utterance.start_time,
        utterance.end_time
        FROM utterance 
        INNER JOIN interview ON utterance.interview_id = interview.interview_id
        LEFT OUTER JOIN utterance_code ON utterance.utterance_id = utterance_code.utterance_id
        INNER JOIN property_value ON utterance_code.property_value_id = property_value.property_value_id
        INNER JOIN coding_property ON property_value.coding_property_id = coding_property.coding_property_id
    ;
    CREATE VIEW IF NOT EXISTS SESSION_DATASET(interview_name, interview_type, client_id, rater_id, session_number,
            language, condition, data_type, variable_name, var_count) AS 
        WITH count_cte(interview_id, property_value_id, var_count) AS (
            SELECT 
                u.interview_id, 
                uc.property_value_id, 
                COUNT(uc.property_value_id)
            FROM utterance_code uc
            INNER JOIN utterance u ON uc.utterance_id = u.utterance_id
            GROUP BY u.interview_id, uc.property_value_id
        ),
        summary_cte(interview_id, summary_variable_id, var_count) AS (
            SELECT 
                u.interview_id, 
                svl.summary_variable_id,
                CASE 
                    WHEN sv.summary_func = 'sum' THEN COUNT(uc.property_value_id) 
                    ELSE AVG(CAST(pv.value AS REAL))
                END AS "var_count"
                FROM utterance_code uc
                INNER JOIN utterance u ON uc.utterance_id = u.utterance_id
                INNER JOIN property_value pv ON uc.property_value_id = pv.property_value_id
                INNER JOIN interview iv ON u.interview_id = iv.interview_id 
                INNER JOIN summary_variable_link svl ON uc.property_value_id = svl.parent_primary_key
                INNER JOIN summary_variable sv ON svl.summary_variable_id = sv.summary_variable_id
                    AND iv.coding_system_id = sv.coding_system_id
                WHERE sv.parent_table_name = 'property_value' 
                GROUP BY u.interview_id, svl.summary_variable_id
        ),
        global_summary_cte(interview_id, summary_variable_id, var_count) AS (
            SELECT
                gr.interview_id,
                sv.summary_variable_id,
                CASE
                    WHEN sv.summary_func = 'sum' then SUM(CAST(gv.value AS REAL))
                    ELSE AVG(CAST(gv.value AS REAL))
                END AS "var_count"
            FROM global_rating gr
            INNER JOIN interview iv ON gr.interview_id = iv.interview_id
            INNER JOIN global_value gv ON gr.global_value_id = gv.global_value_id
            INNER JOIN summary_variable_link svl ON gv.global_property_id = svl.parent_primary_key
            INNER JOIN summary_variable sv ON svl.summary_variable_id = sv.summary_variable_id
                AND iv.coding_system_id = sv.coding_system_id
            WHERE sv.parent_table_name = 'global_value'
            GROUP BY interview.interview_id, sv.summary_variable_id
                
        ),
        global_cte(interview_id, variable_name, value, global_property_id) AS (
        SELECT 
            global_rating.interview_id, 
            global_property.variable_name, 
            global_value.value,
            global_value.global_property_id
        FROM global_rating
        INNER JOIN global_value on global_rating.global_value_id = global_value.global_value_id
        LEFT OUTER JOIN global_property ON global_value.global_property_id = global_property.global_property_id
        )
        SELECT 
            interview.interview_name, 
            interview.interview_type, 
            interview.client_id, 
            interview.rater_id, 
            interview.session_number, 
            interview.language, 
            interview.condition,
            'numeric' AS "data_type",
            pv.variable_name, 
            CASE WHEN count_cte.var_count IS NULL THEN 0 ELSE count_cte.var_count END AS "var_count"
        FROM interview
        INNER JOIN coding_system cs ON interview.coding_system_id = cs.coding_system_id
        INNER JOIN coding_property cp ON cs.coding_system_id = cp.coding_system_id
        INNER JOIN property_value pv ON cp.coding_property_id = pv.coding_property_id
        LEFT OUTER JOIN count_cte ON interview.interview_id = count_cte.interview_id 
            AND pv.property_value_id = count_cte.property_value_id
        UNION ALL
        SELECT 
            interview.interview_name, 
            interview.interview_type, 
            interview.client_id,
            interview.rater_id, 
            Interview.session_number,
            interview.language, 
            interview.condition, 
            global_property.data_type,
            global_cte.variable_name, 
            global_cte.value
        FROM interview
        INNER JOIN coding_system ON interview.coding_system_id = coding_system.coding_system_id 
        INNER JOIN global_property ON global_property.coding_system_id = coding_system.coding_system_id
        LEFT OUTER JOIN global_cte ON interview.interview_id = global_cte.interview_id AND
            global_property.global_property_id = global_cte.global_property_id
        UNION ALL
        SELECT
            interview.interview_name,
            interview.interview_type, 
            interview.client_id, 
            interview.rater_id,
            interview.session_number,
            interview.language, 
            interview.condition,
            'numeric' AS "data_type",
            summary_variable.variable_name,
            CASE WHEN summary_cte.var_count IS NULL THEN 0 ELSE summary_cte.var_count END AS "var_count"
        FROM interview
        INNER JOIN summary_variable ON interview.coding_system_id = summary_variable.coding_system_id
        LEFT OUTER JOIN summary_cte ON interview.interview_id = summary_cte.interview_id
            AND summary_variable.summary_variable_id = summary_cte.summary_variable_id
        UNION ALL
        SELECT
            interview.interview_name, 
            interview.interview_type,
            interview.client_id,
            interview.rater_id,
            interview.session_number,
            interview.language,
            interview.condition,
            'numeric' AS "data_type",
            summary_variable.variable_name,
            CASE WHEN global_summary_cte.var_count IS NULL THEN 0 ELSE global_summary_cte.var_count END AS "var_count"
        FROM interview
        INNER JOIN summary_variable ON interview.coding_system_id = summary_variable.coding_system_id
        LEFT OUTER JOIN global_summary_cte ON interview.interview_id
            AND summary_variable.summary_variable_id = global_summary_cte.summary_variable_id
    ;
    """

