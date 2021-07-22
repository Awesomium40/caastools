from caastools import stats
import numpy
import os
import pandas


script_dir = os.path.dirname(__file__)
td_folder = os.path.join(script_dir, 'test_data', 'datasets')

sl = pandas.read_pickle(os.path.join(td_folder, 'session_level.pkl'))
seq = pandas.read_pickle(os.path.join(td_folder, 'sequential.pkl')).reset_index(drop=False)

# Steps to prepare sequential dataset for alpha
seq_alpha = seq.loc[:, ['client_id', 'utt_enum', 'rater_id', 'MISC']].copy()  # type: pandas.DataFrame
seq_alpha['client_id'] = seq_alpha['client_id'].astype(numpy.float_).astype(numpy.int_)
seq_alpha['str_enum'] = seq_alpha['utt_enum'].apply(lambda x: str(x).zfill(4))
seq_alpha['subject'] = seq_alpha['client_id'].astype(str) + "." + seq_alpha['str_enum'].astype(str)
seq_alpha = seq_alpha.drop(columns=['utt_enum', 'client_id', 'str_enum']).sort_values(['subject', 'rater_id'])\
    .pivot(index='rater_id', columns='subject', values='MISC')


# Steps to prepare SL dataset for alpha
sl_alpha = sl.reset_index(drop=False).loc[:, ['client_id', 'rater_id', 'Empathy']]  # type: pandas.DataFrame
sl_alpha['client_id'] = sl_alpha['client_id'].astype(numpy.float_).astype(numpy.int_)
sl_alpha = sl_alpha.sort_values(['client_id', 'rater_id'])
sla = sl_alpha.pivot(index='rater_id', columns='client_id', values='Empathy')

stats.kalpha(None)