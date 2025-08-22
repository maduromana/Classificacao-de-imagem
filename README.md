# Classificação de Imagens – Ferragem Exposta

Projeto desenvolvido na disciplina de **Probabilidade e Estatística**, com o objetivo de classificar imagens que apresentam ou não **ferragem exposta** em estruturas.

---

## Descrição

O projeto utiliza **R** para implementar um modelo simples de classificação.  
A ideia central é identificar se uma imagem contém regiões com ferragem exposta a partir de cortes de uma imagem maior.

---

## Conteúdo do Repositório

| Arquivo                        | Descrição                                                                 |
|--------------------------------|----------------------------------------------------------------------------|
| `classificacao.r`                     | Código em R responsável pela classificação das imagens                    |
| `comExposição.png`             | Recorte da imagem **com** ferragem exposta (usado no treinamento)         |
| `semExposição.png`             | Recorte da imagem **sem** ferragem exposta (usado no treinamento)         |
| `tudo2.png`                    | Imagem completa que será classificada                                    |
| `Apresentação Ferragem Exposta.pdf` | Slides da apresentação do projeto para a disciplina de Probabilidade e Estatística |

---

## Como Executar

1. Abra o arquivo `classificacao.r` em um ambiente R (RStudio ou terminal R).  
2. Certifique-se de que as imagens (`comExposição.png`, `semExposição.png` e `tudo2.png`) estão no mesmo diretório.  
3. Execute o script para treinar e testar a classificação.  
4. O modelo irá indicar se a imagem `tudo2.png` contém ou não ferragem exposta.  

---

## Autores

- **Eduarda de Souza Turrina**  
- **Maria Eduarda Romana**

---

## Licença 

Projeto acadêmico.
