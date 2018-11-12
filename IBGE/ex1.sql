-- Nomes dos municípios que fazem fronteira com Cajazeiras
SELECT m1.nm_municip
FROM municipio m1, municipio m2
WHERE ST_Touches(m1.geom, m2.geom)
AND m2.nm_municip ILIKE 'cajazeiras'

--Nomes dos municípios do ceará que fazem fronteira com Cajazeiras

SELECT m1.nm_municip
FROM municipio m1, municipio m2, estado e
WHERE ST_Within(m1.geom, e.geom)
AND e.nm_estado ILIKE 'ceará'
AND ST_Touches(m1.geom, m2.geom)
AND m2.nm_municip ILIKE 'Cajazeiras'

-- Nomes dos municípios distantes até 30 km de Cajazeiras (utilize distância em km = distância em graus * 40075/360)

SELECT m1.nm_municip, ST_Distance(ST_Centroid(m1.geom),ST_Centroid(m2.geom))*40075/360 as distancia
FROM municipio m1, municipio m2
WHERE m2.nm_municip ILIKE 'Cajazeiras'
AND ST_Distance(ST_Centroid(m1.geom),ST_Centroid(m2.geom))*40075/360 <30
AND m1.nm_municip not ILIKE 'Cajazeiras'
--Distância entre Cajazeiras e João Pessoa
SELECT ST_Distance(ST_Centroid(m1.geom), ST_Centroid(m2.geom)) * 40075/360
FROM municipio m1, municipio m2
WHERE m1.nm_municip ilike 'cajazeiras'
AND m2.nm_municip ilike 'joão pessoa'

--Maior cidade da mesorregião sertão paraibano
SELECT m.nm_municip, ST_Area(m.geom) * ((40075/360)^2) as area
FROM municipio m, mesorregiao me
WHERE me.nm_meso ilike 'sertão paraibano'
AND ST_Contains(me.geom,ST_Centroid(m.geom))
ORDER BY area DESC
LIMIT 1

-Cidade da Paraíba com maior área
SELECT m.nm_municip, ST_Area(m.geom) * ((40075/360)^2) as area
FROM municipio m, estado e
WHERE e.nm_estado ilike 'paraíba'
AND ST_Contains(e.geom,ST_Centroid(m.geom))
ORDER BY area DESC
LIMIT 1

--Cidade da Paraíba com maior perímetro
SELECT m.nm_municip, ST_Area(m.geom) * (40075/360) as perimetro
FROM municipio m, mesorregiao me
WHERE me.nm_meso ilike 'sertão paraibano'
AND ST_Contains(me.geom,ST_Centroid(m.geom))
ORDER BY perimetro DESC
LIMIT 1
--Dado um ponto, retornar o nome do município que ele está contido
SELECT nm_municip
FROM municipio
WHERE ST_Contains(geom, ST_GeomFromText('POINT(-38.544732 -6.889714 )'))

