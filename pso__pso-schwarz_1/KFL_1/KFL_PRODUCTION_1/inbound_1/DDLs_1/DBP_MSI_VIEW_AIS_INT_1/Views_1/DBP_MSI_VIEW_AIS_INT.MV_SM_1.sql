CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SM_1
-- 29.07.2020 lsvi0303: NSR1559407 Attribut Sortimentskategorie/K-Sortimentskategorie anpassen, ksst values in sm_id column
(
  mandant_id
, sm_id
, sm_kbez
, sm_bez
, sm_bez_de
, sm_bez_cz
, sm_bez_sk
, sm_bez_hr
, sm_bez_pl
, sm_bez_ro
, sm_bez_bg
, sap_sm_id
)
AS
SELECT
  v01.mandant_id
, CAST(TRIM(CASE WHEN v01.sm_id in (11,12,13,14,15,16,17,18,19) THEN sap_sm_id ELSE to_varchar(sm_id) END) AS VARCHAR(2)) AS sm_id
, CASE  WHEN v01.sm_id = '-1' THEN 'keine' ELSE to_varchar(v01.sm_id) END AS sm_kbez
, Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.sm_bez END),'N/A') AS sm_bez                                                             -- Standard == DE
, Coalesce(Max(CASE WHEN v01.spr_id =  22  THEN v01.sm_bez END),'N/A') AS sm_bez_de                                                     -- DE
, Coalesce(Max(CASE WHEN v01.spr_id = 124 THEN v01.sm_bez END), sm_bez_de) AS sm_bez_cz  -- CZ
, Coalesce(Max(CASE WHEN v01.spr_id = 108 THEN v01.sm_bez END), sm_bez_de) AS sm_bez_sk -- SK
, Coalesce(Max(CASE WHEN v01.spr_id =  65  THEN v01.sm_bez END), sm_bez_de) AS sm_bez_hr    -- HR
, Coalesce(Max(CASE WHEN v01.spr_id =  90  THEN v01.sm_bez END), sm_bez_de) AS sm_bez_pl    -- PL
, Coalesce(Max(CASE WHEN v01.spr_id =  95  THEN v01.sm_bez END), sm_bez_de) AS sm_bez_ro   -- RO
, Coalesce(Max(CASE WHEN v01.spr_id =  18  THEN v01.sm_bez END), sm_bez_de) AS sm_bez_bg  -- BG
, v01.sap_sm_id

FROM dbp_view.v_sm_1 v01
GROUP BY 
  v01.mandant_id
, v01.sm_id
, sm_kbez
, v01.sap_sm_id;