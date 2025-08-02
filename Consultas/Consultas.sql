--Músicas mais executadas por artista
SELECT
    ar.nome AS artista,
    m.titulo AS musica,
    COUNT(*) AS total_execucoes
FROM historico h
JOIN musicas m ON h.id_musica = m.id
JOIN albuns a ON m.id_album = a.id
JOIN artistas ar ON a.id_artista = ar.id
GROUP BY ar.nome, m.titulo
ORDER BY ar.nome, total_execucoes DESC;

--Top 10 músicas mais executadas (todas, de qualquer artista)
SELECT
    ar.nome AS artista,
    m.titulo AS musica,
    COUNT(*) AS total_execucoes
FROM historico h
JOIN musicas m ON h.id_musica = m.id
JOIN albuns a ON m.id_album = a.id
JOIN artistas ar ON a.id_artista = ar.id
GROUP BY ar.nome, m.titulo
ORDER BY total_execucoes DESC
LIMIT 10;

--Música mais ouvida no último mês

SELECT
    m.titulo,
    COUNT(*) AS execucoes
FROM historico h
JOIN musicas m ON h.id_musica = m.id
WHERE h.data_execucao >= DATE('now', '-30 days')
GROUP BY m.id
ORDER BY execucoes DESC
LIMIT 1;

--Playlists de um usuário específico (por nome ou ID)

SELECT p.nome AS playlist
FROM playlists p
JOIN usuarios u ON p.id_usuario = u.id
WHERE u.nome = 'João da Silva';

--Média de duração das músicas por artista
SELECT
    *ar.nome AS artista,*

    *round(AVG(m.duracao\_segundos),2) AS media\_duracao*

FROM musicas m
JOIN albuns a ON m.id_album = a.id
JOIN artistas ar ON a.id_artista = ar.id
GROUP BY ar.id
ORDER BY media_duracao DESC;

--Álbuns e quantidade de músicas

SELECT
    a.titulo AS album,
    COUNT(m.id) AS qtd_musicas
FROM albuns a
LEFT JOIN musicas m ON m.id_album = a.id
GROUP BY a.id
ORDER BY qtd_musicas DESC;

--Listar todos os usuários que já ouviram alguma música, sem repetições.

SELECT DISTINCT u.nome
FROM historico h
JOIN usuarios u ON h.id_usuario = u.id;

--Calcular a duração total (em segundos) das músicas de um artista específico.

SELECT
    ar.nome AS artista,
    SUM(m.duracao_segundos) AS duracao_total
FROM musicas m
JOIN albuns a ON m.id_album = a.id
JOIN artistas ar ON a.id_artista = ar.id
WHERE ar.nome = 'Jesse Jones'
GROUP BY ar.nome;

-- Mostrar apenas álbuns com mais de 3 músicas
SELECT
    a.titulo AS nome_album,
    m.id_album,
    COUNT(*) AS qtd_musicas
FROM musicas m
JOIN albuns a ON m.id_album = a.id
GROUP BY m.id_album, a.titulo
HAVING COUNT(*) > 3
ORDER BY qtd_musicas DESC;

