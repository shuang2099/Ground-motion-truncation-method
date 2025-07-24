# Ground-motion-truncation-method
Time history analysis is considered as one of the most commonly used methods to evaluate the seismic performance of structures. But it is time-consuming for the computation cases such as complex structures and ground motions with long duration. Two ground motion truncation methods were proposed to save the computational time.The truncation point of ground motion is determined as follow:

  -Method (1): the time when the peak displacement occurs in a series of single-degree-of-freedom (SDOF) systems relevant to the structure (corresponding to the "SDOF based method" file folder);
  -Method (2): the prediction result from a novel 2D-CNN-BiGRU based deep neural network (DNN) model (corresponding to the "DNN based method" file folder).

The trained model can be used to predict the truncation point of ground motions directly, while the calculation results in the ‘SDOF based method’ folder can be used to generate the dataset required for DNN model training.

Other details can be found in the following reference:

Shuang Li*, Yiting He, Yuliang Wei. Truncation method of ground motion records based on the equivalence of structural maximum displacement responses. Journal of Earthquake Engineering, 2022, 26(10): 5268-5289.

Yiting He, Jianjun Zhao*, Lan Yao, Shuang Li*. A deep learning-based ground motion truncation method to improve efficiency of structural time history analysis. Structures, 2024, 63: 106381. 
