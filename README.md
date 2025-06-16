# Descrição
  Codigos para em objective C para o trabalho final de Modelagem de sistemas dinámicos, consiste em um estudo sobre a modelagem de sitemas caixa preta, onde temos um conjunto de entradas e saidas e buscamos saber a função de transferência do sistema e outros parâmetros. Para execuatr os códigos, basta abrilos no matlab, lembrado que o arquivo txt de dados tem que estar na pasta que o matlab está sendo executado, caso não estaja mude para o diretório coreto. 

## Exercio 1

### Método das intregrais

  
  MSE: 0.017829
  
  Função de Transferência: H(s) = 3.9568 * exp(-19.7156s) / ((54.2947s + 1))
  
![alt text](https://github.com/claragomesac/Trabalho-Final-Modelagem/blob/main/imagens/integrais.jpg?raw=true)

### Método de uma Constante de Tempo (63,2%)

  
  MSE: 0.025774
  
  Função de Transferência: H(s) = 1 * exp(-13s) / (67s + 1)
  

![alt text](https://github.com/claragomesac/Trabalho-Final-Modelagem/blob/main/imagens/constTempo.jpg?raw=true)

### Método Smith

  
  MSE: 0.0208
  
  Função de Transferência: H(s) = 3.9568 * exp(-19.55s) / (60.45s + 1)
  
![alt text](https://github.com/claragomesac/Trabalho-Final-Modelagem/blob/main/imagens/smith.jpg?raw=true)

### Método Sundaresan

  
  MSE: 0.0476
  
![alt text](https://github.com/claragomesac/Trabalho-Final-Modelagem/blob/main/imagens/sundaresan.jpg?raw=true)

### Método mollenkamp

  
  MSE: 0.018113
  
  
![alt text](https://github.com/claragomesac/Trabalho-Final-Modelagem/blob/main/imagens/mollenkamp.jpg?raw=true)


### Análise de resultados

  Como podemos perceber pelo MSE o método das integrais é mais preciso, uma vez qu enão depende de nehuma visualisação dos dados, mas em contra partida é menos intuitivo. O método de Smitch se mostra uma ótima opção, já que possiu um MSE baixo e é de viasualização mais rápida e facil.
