install.packages('OpenImageR')
library(OpenImageR) #instalar

#lendo imagem TUDO
tudo=readImage("tudo2.jpg")
imageShow(tudo)
dim(tudo) #linhas x colunas x matrix(R, G, B)
480*640 #cada matriz

#imagem[Linha,Coluna,Matrix]
tudo2=tudo #nao perder original
tudo2[,1:400,3]=0 #zerar blue colunas
imageShow(tudo2)

tudo2[,1:400,2]=0 #zerar B,G colunas
imageShow(tudo2)

tudo2[,1:400,1]=0 #zerar R,G,B colunas
imageShow(tudo2)

#lendo imagem sem exposição
sem=readImage('semExposicao.png')
imageShow(sem)

#lendo imagem com exposicao
com=readImage('comExposicao.png')
imageShow(com)



dim(sem)
247*313

#(R, G, B)
c(sem[,,1])
length(c(sem[,,1]))
msem=cbind(c(sem[,,1]),
             c(sem[,,2]),
             c(sem[,,3]))

dim(msem)

mcom=cbind(c(com[,,1]),
            c(com[,,2]),
            c(com[,,3]))

#Muitos dados,trabalhar com amostra
# suponha que eu quero uma amostra de tamanho 4 dos números 1, 2, 3, 4, 5
sample(1:5,4)

dim(msem) # amostra de tamanho 10k
dim(mcom) # amostra de 5k 


msem=msem[sample(1:77311,10000),]
dim(msem)
mcom=mcom[sample(1:15244,5000),]
dim(mcom)



#arrumando dados (0=sem, 1=com)
cbind(msem,0)
cbind(mcom,1)


dados=rbind(cbind(msem,0),cbind(mcom,1))
head(dados)
colnames(dados)=c("R","G","B",'Y')
head(dados)
dim(dados)



library(randomForest)
modelo=randomForest(as.factor(Y)~R+G+B,data=dados)
print(modelo)
importance(modelo)



#predicao imagem tudo
mtudo=cbind(c(tudo[,,1]),
            c(tudo[,,2]),
            c(tudo[,,3]))

head(mtudo)
colnames(mtudo)=c('R',"G","B")
head(mtudo) #(0=sem, 1=com)


pred=predict(modelo,newdata = mtudo)
table(pred)
table(as.numeric(pred)) #transforma numero

pred=as.numeric(pred)-1 #voltar ao original
table(pred)



ncol(tudo[,,3]) #quantas colunas original
mpred=matrix(pred,ncol=640)

imageShow(mpred)
imageShow(tudo)


#(0=sem, 1=com)
tudo2=tudo
tudo2[,,1][pred==1]=1
imageShow(tudo2)


tudo2=tudo
tudo2[,,2][pred==0]=1
imageShow(tudo2)


tudo2=tudo
tudo2[,,1][pred==0]=0
tudo2[,,2][pred==0]=0
tudo2[,,3][pred==0]=0

tudo2[,,3][pred==1]=0

imageShow(tudo2)


### qual a % de exposicao ?
tabela=table(pred)
tabela[2]/(tabela[1]+tabela[2])

