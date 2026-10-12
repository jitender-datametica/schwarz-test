CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_VKL
(
   mandant_id
  ,vkl_id
  ,gf_id
  ,vkl_name
  ,vkl_name_cz
  ,vkl_name_sk
  ,vkl_name_hr
  ,vkl_name_pl
  ,vkl_name_ro
  ,vkl_name_bg
)
AS
-- 08.05.2018 twie: SPEC0037245 Erweiterung um Dummy VKL für die Dummy WUP pro GF in DE für Maritz
-- 04.06.2019 twie: SPEC0056220 Umstellung auf Mehrsprachig, Logik aus VIS übernommen mit Namen aus der ma_spr_zu
-- 01.07.2019 twie: SPEC0058279 gf_id für Dummy ZF/Maritz nicht aus vkl Tabelle - da dort nicht gepflegt - sondern aus der wup Tabelle

   SELECT
     mandant_id
     , ma_id AS vkl_id
     , gf_id
     , MAX(CASE WHEN spr_id = 22 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END)    AS vkl_name
     , COALESCE(MAX(CASE WHEN spr_id = 124 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)       AS vkl_name_cz
     , COALESCE(MAX(CASE WHEN spr_id = 108 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)       AS vkl_name_sk
     , COALESCE(MAX(CASE WHEN spr_id =   65 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)       AS vkl_name_hr
     , COALESCE(MAX(CASE WHEN spr_id =   90 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)       AS vkl_name_pl
     , COALESCE(MAX(CASE WHEN spr_id =   95 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)       AS vkl_name_ro
     , COALESCE(MAX(CASE WHEN spr_id =   18 THEN (msz.ma_anrede || ' ' || msz.ma_vorname || ' ' || msz.ma_name) END), vkl_name)       AS vkl_name_bg

   FROM (
    SELECT 
    v01.mandant_id
    , v01.ma_id
    , v01.ma_name
    , v01.ma_vorname
    , v01.ma_anrede
    , v01.spr_id
    , v02.gf_id

   FROM dbp_view.v_ma_spr_zu v01

   --Ermittlung gf_id über vkl Tabelle
   INNER JOIN dbp_view.v_vkl v02
   ON v01.ma_id = v02.vkl_id
   AND v01.mandant_id  = v02.mandant_id

  WHERE (v01.mandant_id, v01.ma_id) IN (
    SELECT mandant_id, vkl_id
   FROM dbp_view.v_wup
   WHERE nb_id IN (0, -1, 2, 7) AND vkl_id <> wup_id
  UNION ALL -- Zentralfilialen
  SELECT mandant_id, (1000 + mandant_id * 100 + vs_id * 10) * -1::INTEGER
   FROM dbp_view.v_vs
   )

UNION ALL -- Dummy ZF/Maritz 

-- für diese Einträge die gf_id aus der wup Tabelle, da in vkl Tabelle nicht gepflegt
 SELECT 
 mandant_id
 , vkl_id
 , wup_standort
 , ''
 , ''
 , 22
 , gf_id
   FROM dbp_view.v_wup
   WHERE nb_id = -1 AND vkl_id = wup_id
 ) msz
 GROUP BY 1, 2, 3;