<h1>caastools</h1>
<p>caastools is a simple package to assist in the management and analysis of data collected from clinical interviews at
the CAAS coding labs. It provides a unified data storage and retrieval framework
as well as statistical implementations for the most commonly used analyses</p>
<p/>
<p>
Installation is simple. 
<ol>
<li>Clone the repository to a folder on your local machine</li>
<li>From the command line, run 'setup.py install' to install from an egg or
'setup.py bdist_wheel' to build a wheel
<ul>
<li>If you built a wheel in step 2, use pip install '&lt;path to wheel&gt;' to install the wheel</li>
</ul></li>
</ol>
</p>
<p>
Dependencies should resolve on their own, but caastools has the following dependencies:
<ul>
<li>lxml &gt;= 4.3.3</li>
<li>peewee &gt;= 3.0</li>
<li>numpy &gt;= 1.16.0</li>
<li>scipy &gt;= 1.3.0</li>
<li>pandas &gt;= 1.0.0</li>
<li>matplotlib &gt;= 3.1.0</li>
<li>seaborn &gt;= 0.10.0</li>
<li>savReaderWriter &gt;= 3.4.0</li>
</ul>
</p>