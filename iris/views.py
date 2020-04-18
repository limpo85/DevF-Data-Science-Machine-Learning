

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier

from django.conf import settings

from rest_framework.decorators import api_view
from rest_framework.response import Response


# Create your views here.
@api_view(['POST', ])
def iris_ml(request):
    try:
        
        data = request.data

        sepalLengthCm = data["SepalLengthCm"]
        sepalWidthCm = data["SepalWidthCm"]
        petalLengthCm = data["PetalLengthCm"]
        petalWidthCm = data["PetalWidthCm"]

        query = [[ sepalLengthCm,  sepalWidthCm,  petalLengthCm,  petalWidthCm]]

        #Importamos el dataset
        iris = pd.read_csv(settings.MEDIA_ROOT+"/csv/Iris.csv")

        #Eliminamos la primera columna ID ya que no la requerimos
        iris = iris.drop('Id',axis=1)

        #Mostramos los primeros 10 registros.
        print(iris.head(10))


        #Análizamos los datos que tenemos disponibles
        print('Info del dataset: ')
        print(iris.info())

        print('Descripcion: ')
        print(iris.describe())

        print('Especies agrupadas:')
        print(iris.groupby('Species').size())


        #Separo todos los datos con las características y las etiquetas o resultados
        X = np.array(iris.drop(['Species'], 1))

        Y = np.array(iris['Species'])

        #Separo los datos de "train" en entrenamiento y "test" prueba para probar algoritmo
        X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.2)
        print('Datos entrenamiento {} y {} datos para pruebas'.format(X_train.shape[0], X_test.shape[0]))

        #Modelo de arboles de Decision clasificacion
        algoritmo = DecisionTreeClassifier()
        algoritmo.fit(X_train, y_train)
        Y_pred = algoritmo.predict(X_test)
        print('Precision de la clasificación: {}'.format(algoritmo.score(X_train, y_train)))

        

        result = algoritmo.predict(query)

        

        return Response({"result": result[0]})

    except Exception as e:
        print(e)
        return Response({'error': str(e)})