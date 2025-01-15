import 'package:flutter/material.dart';

var charts = [
  const DropdownMenuItem(
    value: "line",
    child: Text("Line Graph"),
  ),
  const DropdownMenuItem(
    value: "area",
    child: Text("Area Graph"),
  ),
  const DropdownMenuItem(
    value: "bar",
    child: Text("Bar Graph"),
  ),
];

List<List<Offset>> xPointValues = [];
List<int> xPointValuesInt = [];
List<List<int>> yPointValuesInt = [];
Map<int, List<int>> yFinalValuesMap = {};
Map<int, int> yFinalValuesSingleMap = {};
//List<double> yFinalValuesSingleMap = [];
//criar um novo array com os valores em Y, a chave das valores têm de ser a coordenada x
//vou preencher as chaves desse array aquando escrevo os labels em Y 
//vou preecher os valores propriamente ditos aquando desenho os pontos de interceção
//ERRO: O primeiro valor e o penúltimo valor estão a ser mal preenchidos 
//As posições estão a ser bem pegues, a ordem é que está mal, tenho valores armazenas em chaves erradas.
//Ex: a chave 47 tem que armazenar 193, mas ele está a armazenar o 160
