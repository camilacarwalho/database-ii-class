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

