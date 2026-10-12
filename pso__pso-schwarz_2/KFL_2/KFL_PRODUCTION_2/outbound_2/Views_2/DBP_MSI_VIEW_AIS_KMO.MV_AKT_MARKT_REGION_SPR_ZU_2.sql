CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_akt_markt_region_spr_zu_2 (akt_region_id, mandant_id,
region_bez, region_bez_de, region_bez_cz, region_bez_sk, region_bez_hr, region_bez_pl, region_bez_ro, region_bez_bg) AS
SELECT V01.region_id AS akt_region_id,
 V01.mandant_id,
  CASE
  WHEN V01.mandant_id = 8
  THEN TRANSLATE(COLLATE(V01.region_name,''), 'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
   'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ')
  ELSE V01.region_name
  END AS region_bez,
  CASE
  WHEN V01.mandant_id = 8
  THEN TRANSLATE(COLLATE(V01.region_name,''), 'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
   'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ')
  ELSE V01.region_name
  END AS region_bez_de,
  CASE
  WHEN V01.mandant_id = 8
  THEN TRANSLATE(COLLATE(V01.region_name,''), 'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
   'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ')
  ELSE V01.region_name
  END AS region_bez_cz,
  CASE
  WHEN V01.mandant_id = 8
  THEN TRANSLATE(COLLATE(V01.region_name,''), 'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
   'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ')
  ELSE V01.region_name
  END AS region_bez_sk,
  CASE
  WHEN V01.mandant_id = 8
  THEN TRANSLATE(COLLATE(V01.region_name,''), 'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
   'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ')
  ELSE V01.region_name
  END AS region_bez_hr,
  CASE
  WHEN V01.mandant_id = 8
  THEN TRANSLATE(COLLATE(V01.region_name,''), 'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
   'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ')
  ELSE V01.region_name
  END AS region_bez_pl,
  CASE
  WHEN V01.mandant_id = 8
  THEN TRANSLATE(COLLATE(V01.region_name,''), 'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
   'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ')
  ELSE V01.region_name
  END AS region_bez_ro,
 V01.region_name AS region_bez_bg
FROM kfl_production_dbp_view.v_region_2 AS V01
 INNER JOIN (SELECT mandant_id,
    CASE
    WHEN mandant_id = 1
    THEN 'DE'
    ELSE mandant_kbez
    END AS land_id
  FROM kfl_production_dbp_view.v_mandant_2) AS v02 ON V01.mandant_id = v02.mandant_id AND V01.land_id = v02.land_id
WHERE V01.mandant_id <> 1;