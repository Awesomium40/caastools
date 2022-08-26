import setuptools
import os

with open(os.path.join(os.path.dirname(__file__), "README.md"), "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="caastools",
    version="1.5.3",
    author="Jay Walthers",
    author_email="justin_walthers@brown.edu",
    description="A package for managing and analyzing Interview data at CAAS",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/Awesomium40/caastools",
    install_requires=['lxml >= 4.3.3', 'numpy >= 1.16.0', 'scipy >= 1.3.0',
                      'pandas >= 1.0.0', 'matplotlib >= 3.1.0', 'savReaderWriter >= 3.4.0'],
    packages=setuptools.find_packages(),
    package_data={'': ['*.xml', '*.xsd', '*.xslt']},
    include_package_data=True,
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: Microsoft :: Windows",
    ],
    python_requires='>=3.6',
)
