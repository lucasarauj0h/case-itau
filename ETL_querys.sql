# O intuito desse arquivo é mostrar que também possuo conhecimento em SQL para realizar as querys feitas em python
# Para poupar tempo, foi utilizado o arquivo csv já com as colunas renomeadas, separadas e no tipo certo de dados (o SGBD identificou automaticamente)
# Mas afim de demonstrar conhecimento deixo um codigo que funcionaria também, caso necessário

# Renomeando colunas.
# ALTER TABLE case_itau_tratado
# CHANGE data_base database int;

# Alterando tipo de dados
# ALTER TABLE case_itau_tratado
# MODIFY COLUMN data_base INT;

# Verificando se há valores ausentes
SELECT *
FROM case_itau_tratado
WHERE data_base IS NULL
   OR score_inicial IS NULL
   OR score_final IS NULL
   OR meses_de_trabalho IS NULL
   OR qntd_carrinhos IS NULL
   OR qntd_carrinhos_danificados IS NULL;
   
# Verificando os dados das colunas numéricas
SELECT
  COUNT(*) AS contagem,
  MIN(qntd_carrinhos) AS minimo,
  MAX(qntd_carrinhos) AS maximo,
  AVG(qntd_carrinhos) AS media,
  STDDEV(qntd_carrinhos) AS desvio_padrao
FROM
  case_itau_tratado;
  
# Criando a coluna com a porcentagem de carrinhos danificados
ALTER TABLE case_itau_tratado
ADD COLUMN perc_danificados DECIMAL(5, 2) GENERATED ALWAYS AS ((qntd_carrinhos_danificados / qntd_carrinhos) * 100) STORED;

# Verificando se há valores ausentes
SELECT *
FROM case_itau_tratado
WHERE data_base IS NULL
   OR score_inicial IS NULL
   OR score_final IS NULL
   OR meses_de_trabalho IS NULL
   OR qntd_carrinhos IS NULL
   OR qntd_carrinhos_danificados IS NULL
   OR perc_danificados IS NULL;
   
# Criando uma nova coluna para identificação 
CREATE TABLE case_itau_tratado3 AS
SELECT
    *,
    CONCAT(SUBSTRING(data_base FROM 6 FOR 1), score_inicial) AS id_database
FROM case_itau_tratado;
DROP TABLE case_itau_tratado;
DROP TABLE case_itau_tratado2;
RENAME TABLE case_itau_tratado3 TO case_itau_tratado;

# Verificando se há valores ausentes
SELECT *
FROM case_itau_tratado
WHERE data_base IS NULL
   OR score_inicial IS NULL
   OR score_final IS NULL
   OR meses_de_trabalho IS NULL
   OR qntd_carrinhos IS NULL
   OR qntd_carrinhos_danificados IS NULL
   OR perc_danificados IS NULL
   OR id_database IS NULL;
  
# Verificando a média de percentual por score_inicial
SELECT score_inicial, ROUND(AVG(perc_danificados),2) as media_percentual_danificados
FROM case_itau_tratado
GROUP BY score_inicial;

# Verificando a média de percentual por meses_de_trabalho
SELECT meses_de_trabalho, ROUND(AVG(perc_danificados),2) as media_percentual_danificados
FROM case_itau_tratado
GROUP BY meses_de_trabalho;

# Verificando a média de percentual por score_inicial e por meses_de_trabalho
SELECT score_inicial, meses_de_trabalho, ROUND(AVG(perc_danificados),2) as media_percentual_danificados
FROM case_itau_tratado
GROUP BY score_inicial, meses_de_trabalho;
