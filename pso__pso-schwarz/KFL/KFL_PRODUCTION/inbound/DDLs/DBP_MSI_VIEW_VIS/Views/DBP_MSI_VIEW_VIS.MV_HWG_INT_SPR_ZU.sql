CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HWG_INT_SPR_ZU
AS 
 -- LOOKUP/Sprache : Hauptwarengruppe (International)
 -- 2017.0320 ssch0611 : Intitial - neue Struktur HWG/Abteilung
 -- 2018.09 ssch0611 : WG Refresh
 -- 2020.07 ssch0611 : new columns (multi-language id + bez)

SELECT DISTINCT
  hwg.arthiertyp_id 
, hwg.hwg_id 
, Max(CASE WHEN spr_id = 22 THEN hwg_bez ELSE Trim(hwg_id) END)      AS hwg_bez_de    -- DE 
, hwg_bez_de                                                         AS hwg_bez       -- default = DE
, Coalesce(Max(CASE WHEN spr_id = 124 THEN hwg_bez END), hwg_bez_de) AS hwg_bez_cz    -- CZ
, Coalesce(Max(CASE WHEN spr_id = 108 THEN hwg_bez END), hwg_bez_de) AS hwg_bez_sk    -- SK
, Coalesce(Max(CASE WHEN spr_id =  65 THEN hwg_bez END), hwg_bez_de) AS hwg_bez_hr    -- HR
, Coalesce(Max(CASE WHEN spr_id =  90 THEN hwg_bez END), hwg_bez_de) AS hwg_bez_pl    -- PL
, Coalesce(Max(CASE WHEN spr_id =  95 THEN hwg_bez END), hwg_bez_de) AS hwg_bez_ro    -- RO
, Coalesce(Max(CASE WHEN spr_id =  18 THEN hwg_bez END), hwg_bez_de) AS hwg_bez_bg    -- BG
  -- ID + BEZ
, Max(Trim(hwg_id)) || ' ' || hwg_bez_de AS hwg_id_bez     -- default = DE
, Max(Trim(hwg_id)) || ' ' || hwg_bez_cz AS hwg_id_bez_cz  -- CZ
, Max(Trim(hwg_id)) || ' ' || hwg_bez_sk AS hwg_id_bez_sk  -- SK
, Max(Trim(hwg_id)) || ' ' || hwg_bez_hr AS hwg_id_bez_hr  -- HR
, Max(Trim(hwg_id)) || ' ' || hwg_bez_pl AS hwg_id_bez_pl  -- PL
, Max(Trim(hwg_id)) || ' ' || hwg_bez_ro AS hwg_id_bez_ro  -- RO
, Max(Trim(hwg_id)) || ' ' || hwg_bez_bg AS hwg_id_bez_bg  -- BG
, Max(Trim(hwg_id)) || ' ' || hwg_bez_de AS hwg_id_bez_de  -- DE

FROM  dbp_view.v_hwg_spr_zu  hwg

WHERE hwg.arthiertyp_id = 2

GROUP BY arthiertyp_id, hwg_id;