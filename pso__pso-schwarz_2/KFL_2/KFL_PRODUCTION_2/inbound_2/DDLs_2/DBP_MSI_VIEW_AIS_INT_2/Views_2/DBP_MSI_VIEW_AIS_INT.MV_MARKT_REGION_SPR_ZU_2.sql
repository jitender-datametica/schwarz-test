CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_MARKT_REGION_SPR_ZU_2
(
REGION_ID,
MANDANT_ID,
REGION_BEZ,
REGION_BEZ_DE,
REGION_BEZ_CZ,
REGION_BEZ_SK,
REGION_BEZ_HR,
REGION_BEZ_PL,
REGION_BEZ_RO,
REGION_BEZ_BG
)
AS
SELECT
 v01.region_id
,v01.mandant_id
,CASE WHEN v01.mandant_id = 8 THEN TRANSLATE (v01.region_name,'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
                                                                'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ') 
		ELSE v01.region_name END region_bez
,CASE WHEN v01.mandant_id = 8 THEN TRANSLATE (v01.region_name,'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
                                                                 'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ') 
		ELSE v01.region_name END region_bez_de
,CASE WHEN v01.mandant_id = 8 THEN TRANSLATE (v01.region_name,'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
                                                                 'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ') 
		ELSE v01.region_name END region_bez_cz
,CASE WHEN v01.mandant_id = 8 THEN TRANSLATE (v01.region_name,'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
                                                                 'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ') 
		ELSE v01.region_name END region_bez_sk
,CASE WHEN v01.mandant_id = 8 THEN TRANSLATE (v01.region_name,'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
                                                                 'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ') 
		ELSE v01.region_name END region_bez_hr
,CASE WHEN v01.mandant_id = 8 THEN TRANSLATE (v01.region_name,'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
                                                                 'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ') 
		ELSE v01.region_name END region_bez_pl
,CASE WHEN v01.mandant_id = 8 THEN TRANSLATE (v01.region_name,'АаБбВвГгДдЕеЖжЗзИиЙйКкЛлМмНнОoПпРрСсТтУуФфХхЦцЧчШшЩщЮюЯяЪъЬь',
                                                                 'AaBbVvGgDdEeŽžZzIiJjKkLlMmNnOoPpRrSsTtUuFfHhCcČčŠšŜŝÛûÂâ') 
		ELSE v01.region_name END region_bez_ro
,v01.region_name AS region_bez_bg

FROM dbp_view.v_region_2 v01
JOIN (SELECT mandant_id, 
      CASE WHEN mandant_id = 1 THEN 'DE' ELSE MANDANT_KBEZ END AS land_id 
      FROM dbp_view.v_mandant_2) v02
ON v01.mandant_id = v02.mandant_id
AND v01.land_id = v02.land_id;