# UCIVIT-LongitudinalVis #

This Web application supports researchers analysis of longitudinal interaction data. Distributions of interaction values at different stages of interaction are provided, as well as regression models through the use of linear mixed models.

This tool comes preloaded with a set of anonymised data, obtained from the School of Computer Science Web site (cs.manchester.ac.uk). This data is the result of data captured using UCIVIT-WebIntCap and processed using UCIVIT-ProcessAndMicroBehaviours. The resulting interaction files were processed using the *MixedModelAnalysis.R* script to produce the *globalEpisodePoolAllUrlsObject.RData* which is used as input for the analysis.

### How do I get set up? ###

The Web application can be run directly using the Manchester test data.

1. The execution of the Web application requires the use of R, and the shiny library. The simplest way to run it is through Rstudio (https://www.rstudio.com/), opening either *ui.R* or *server.R*, and clicking on "Run App".
2. The Web application opens automatically in a Web browser and loads the data with the predefined options.
3. The different steps provide different functionalities, which require different ways of execution.

### Using output data from UCIVIT-ProcessAndMicroBehaviours

If you have perform the analysis described in [UCIVIT-ProcessAndMicroBehaviours](https://github.com/aapaolaza/UCIVIT-ProcessAndMicroBehaviours), you can use that resulting data instead of the one provided with this repository.

1. First, delete or rename the "globalEpisodePoolAllUrlsObject.RData" file in the */data* folder. The following steps will replace this file.
1. Move the resulting csv files (they should be in the folder *Step3_Analysis_extractors/data/combinedCSV/*) to the *data* folder.
1. Open the *MixedModelAnalysis.R* with Rstudio, and press the "Source" button. All necessary libraries will be installed automatically. Depending on how many dependencies are missing, this step can take several minutes.
1. Run the *loadAllEpisodes()* function. It reads all existing CSV files, and creates a single R object with them. It can take several hours depending on the machine. In a test with an i7 with SSD hard disk, it took around 80 minutes.
1. Run the *saveLoadAllEpisodes()* to create the RData object.
1. A file called "globalEpisodePoolAllUrlsObject.RData" should have been created in the */data/* folder.
1. Execute the Web application as described in the previous section.

###Contact###
For questions, or help using this tool, contact Aitor Apaolaza (aitor.apaolaza@manchester.ac.uk)

###Publications###
The design of this tool supported the following publications:
* *Understanding users in the wild* in the Proceedings of the 10th International Cross-Disciplinary Conference on Web Accessibility.
* *Identifying emergent behaviours from longitudinal web use* in the Proceedings of the adjunct publication of the 26th annual ACM symposium on User interface software and technology
* *Longitudinal analysis of low-level Web interaction through micro behaviours* in the Proceedings of the 26th ACM Conference on Hypertext & Social Media

###Acknowledgements###
This work was supported by the Engineering and Physical Sciences Research Council [EP/I028099/1].
