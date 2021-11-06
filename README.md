<h1>caastools</h1>
<p>caastools is a simple package to assist in the management and analysis of data collected from clinical interviews at
the CAAS coding labs. It provides a unified data storage and retrieval framework
as well as statistical implementations for the most commonly used analyses</p>
<p>
Installation is simple. 
</p>
<ul>
<li><i>Preferred</i>: download the most recent version of the caastools wheel (currently <a href="https://github.com/Awesomium40/caastools/blob/master/dist/caastools-1.0.9.15-py3-none-any.whl">v1.0.9.15</a>)
and install via pip -> <code>pip install path_to_wheel</code></li>
<li>Clone the repository to a folder on your local machine</li>
<li>You can also install via:
    <ul>
        <li>Clone the repository to your local machine</li>
        <li>From the caastools folder, run <code>setup.py install</code> to install from an egg, or 
        <code>setup.py bdist_wheel</code> to build a wheel and install as instructed above</li>
    </ul>
</li>

</ul>
<p>
Dependencies should resolve on their own, but caastools has the following dependencies:
</p>
<ul>
<li>lxml &gt;= 4.3.3</li>
<li>peewee &gt;= 3.0</li>
<li>numpy &gt;= 1.16.0</li>
<li>scipy &gt;= 1.3.0</li>
<li>pandas &gt;= 1.0.0</li>
<li>matplotlib &gt;= 3.1.0</li>gi
<li>savReaderWriter &gt;= 3.4.0</li>
</ul>
 
<h2>Usage</h2>