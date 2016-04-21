# UCIVIT-LongitudinalVis #

Web application. Distributions of interaction values at different stages of interaction are provided, as well as regression models through the use of linear mixed models.

This tool comes preloaded with a set of anonymised data, obtained from the School of Computer Science Web site (cs.manchester.ac.uk). This data is the result of data captured using UCIVIT-WebIntCap and processed using UCIVIT-ProcessAndMicroBehaviours. The resulting interaction files were processed using the *microbehaviourProcessAndAnalysis.R* script to produce the *globalEpisodePoolAllUrlsObject.RData* which is used as input for the analysis.

### How do I get set up? ###

The Web application can be run directly using the Manchester test data.

1. The execution of the Web application requires the use of R, and the shiny library. The simplest way to run it is through Rstudio (https://www.rstudio.com/), opening either *ui.R* or *server.R*, and clicking on "Run App".
2. The Web application opens automatically in a Web browser and loads the data with the predefined options.
3. Before running any of the steps, the files *shellVariables.sh* and *MapreduceConstants* need to be filled with the information concerning the database installation.
4. The different steps provide different functionalities, which requires different ways of execution.

###Contact###
For questions, or help using this tool, contact Aitor Apaolaza (aitor.apaolaza@manchester.ac.uk)

###Publications###
The design of this tool supported the following publications:
* *Understanding users in the wild* in the Proceedings of the 10th International Cross-Disciplinary Conference on Web Accessibility.
* *Identifying emergent behaviours from longitudinal web use* in the Proceedings of the adjunct publication of the 26th annual ACM symposium on User interface software and technology
* *Longitudinal analysis of low-level Web interaction through micro behaviours* in the Proceedings of the 26th ACM Conference on Hypertext & Social Media

###Acknowledgements###
This work was supported by the Engineering and Physical Sciences Research Council [EP/I028099/1].