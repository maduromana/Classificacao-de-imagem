# Instalando e carregando pacotes necessários
install.packages(c('OpenImageR', 'randomForest', 'caret'))
library(OpenImageR)
library(randomForest)
library(caret)

# Lendo imagem original
tudo = readImage("tudo2.jpg")
imageShow(tudo)

# Pré-processamento para destacar ferragem
tudo2 = tudo
tudo2[, 1:400, 3] = 0  # Zerar a componente azul
imageShow(tudo2)
tudo2[, 1:400, 2] = 0  # Zerar as componentes verde e azul
imageShow(tudo2)
tudo2[, 1:400, 1] = 0  # Zerar todas as componentes
imageShow(tudo2)

# Lendo imagens de referência
sem = readImage('semExposicao.png')
com = readImage('comExposicao.png')

# Convertendo para formato de matriz
msem = as.matrix(sem)
mcom = as.matrix(com)

# Amostragem dos dados
set.seed(123)  # Para reprodutibilidade
msem = msem[sample(1:nrow(msem), 10000), ]
mcom = mcom[sample(1:nrow(mcom), 5000), ]

# Criando e organizando dados
dados = rbind(cbind(msem, 0), cbind(mcom, 1))
colnames(dados) = c("R", "G", "B", 'Y')

# Treinamento do modelo
modelo = randomForest(as.factor(Y) ~ R + G + B, data = dados)
print(modelo)
importance(modelo)

# Predição na imagem original
mtudo = as.matrix(tudo)
pred = predict(modelo, newdata = mtudo)

# Visualizando resultados
tudo2 = tudo
tudo2[, , 1][pred == 1] = 1
imageShow(tudo2)

# Métricas de Avaliação
test_labels = rep(c(0, 1), each = 5000)
conf_matrix = confusionMatrix(table(as.numeric(pred), test_labels))
accuracy = conf_matrix$overall["Accuracy"]
precision = conf_matrix$byClass["Pos Pred Value"]


# Porcentagem de Ferragem Exposta
percentage_exposed = sum(pred == 1) / length(pred) * 100

# Imprimindo resultados
cat("Acurácia do modelo:", round(accuracy * 100, 2), "%\n")

cat("Precisão do modelo:", round(precision * 100, 2), "%\n")
cat("Porcentagem de ferragem exposta na imagem:", round(percentage_exposed, 2), "%\n")
