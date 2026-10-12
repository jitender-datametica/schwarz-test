CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_LOG.MV_DT_LAGERNUMMER_TMS(
	MANDANT_ID,
    EWM_FG,
	TMS_GP_ID,
    TMS_GP_ID_ANZEIGE,
	TMS_GP_TYP_CD,
	TMS_GP_LFD_NR,
	TMS_GP_NAME,
	TMS_GP_ALTNV_NAME,
	TMS_GP_STRASSE,
	TMS_GP_ORT_NAME,
	TMS_GP_PLZ,
	TMS_LAND_CD,
	SPERR_FG,
	SAMMELBELEG_ID,
	TMS_STANDORTTYP_ID,
    DAT_WANKO_VON,
    lagernummer_bez,
    lagernummer_bez_de,
    lagernummer_bez_cz,
    lagernummer_bez_sk,
    lagernummer_bez_hr,
    lagernummer_bez_pl,
    lagernummer_bez_ro,
    lagernummer_bez_bg
) 
TARGET_LAG = '60 minutes'
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG 
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG 
AS
--AP0230823,SPEC0266004, dknop, initial
--adding desc for other languages
--2025-01-29, nwag, FLW
--2025-03-11, nwag, move to DT
SELECT  --EWM DCs once they're live
v01.mandant_id
,1 AS ewm_fg
,v01.tms_gp_id
,v03.lagernummer_id AS TMS_GP_ID_ANZEIGE
,v01.tms_gp_typ_cd
,v01.tms_gp_lfd_nr
,v01.tms_gp_name
,v01.tms_gp_altnv_name
,v01.tms_gp_strasse
,v01.tms_gp_ort_name
,v01.tms_gp_plz
,v01.tms_land_cd
,v01.sperr_fg
,v01.sammelbeleg_id
,v01.tms_standorttyp_id
,v000.dat_wanko_von
,MAX(CASE WHEN v04.spr_id = 22 THEN v04.lagernummer_bez END) AS lagernummer_bez
,MAX(CASE WHEN v04.spr_id = 22 THEN v04.lagernummer_bez END) AS lagernummer_bez_de
,COALESCE(MAX(CASE WHEN v04.spr_id = 124 THEN v04.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_cz    -- CZ
,COALESCE(MAX(CASE WHEN v04.spr_id = 108 THEN v04.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_sk    -- SK
,COALESCE(MAX(CASE WHEN v04.spr_id =  65 THEN v04.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_hr    -- HR
,COALESCE(MAX(CASE WHEN v04.spr_id =  90 THEN v04.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_pl    -- PL
,COALESCE(MAX(CASE WHEN v04.spr_id =  95 THEN v04.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_ro    -- RO
,COALESCE(MAX(CASE WHEN v04.spr_id =  18 THEN v04.lagernummer_bez END), lagernummer_bez_de) AS lagernummer_bez_bg    -- BG
FROM dbp_view.v_tms_gp v01

JOIN dbp_view.v_L_SYSTEM sys 
ON sys.system_id=v01.system_id
AND LEFT(sys.SYSTEM_BEZ,4) = 'KTMS' AND LEFT(sys.KL_SYSTEM_BEZ,3)  <> 'FLW' 

JOIN dbp_view.v_wup v02
ON v01.mandant_id=v02.mandant_id
AND TRY_CAST(v01.tms_gp_id AS NUMBER) = v02.wup_id
AND v02.nb_id=-111

JOIN DBP_VIEW.V_L_LAGERNUMMER v03 ON v02.mandant_id=v03.mandant_id AND v02.wup_id=v03.wup_id AND v03.ewm_fg=1

JOIN DBP_VIEW.V_LAGERNUMMER_SPR_ZU v04 ON v04.mandant_id=v03.mandant_id AND v04.lagernummer_id=v03.lagernummer_id

JOIN (SELECT MANDANT_ID, WUP_ID , MIN(COALESCE(v00.dat_tms_wanko, DATE'9999-12-31')) AS dat_wanko_von 
FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM v00 GROUP BY MANDANT_ID, WUP_ID) v000
ON v02.mandant_id=v000.mandant_id AND v02.wup_id=v000.wup_id

WHERE tms_gp_typ_cd='L'
GROUP BY v01.mandant_id
,v01.tms_gp_id
,v03.lagernummer_id
,v01.tms_gp_typ_cd
,v01.tms_gp_lfd_nr
,v01.tms_gp_name
,v01.tms_gp_altnv_name
,v01.tms_gp_strasse
,v01.tms_gp_ort_name
,v01.tms_gp_plz
,v01.tms_land_cd
,v01.sperr_fg
,v01.sammelbeleg_id
,v01.tms_standorttyp_id
,v000.dat_wanko_von
UNION
SELECT DISTINCT --LES DCs if they still existed before WANKO golive
v01.mandant_id
,0 AS ewm_fg
,v01.tms_gp_id
,v02.wup_id::VARCHAR AS TMS_GP_ID_ANZEIGE
,v01.tms_gp_typ_cd
,v01.tms_gp_lfd_nr
,v01.tms_gp_name
,v01.tms_gp_altnv_name
,v01.tms_gp_strasse
,v01.tms_gp_ort_name
,v01.tms_gp_plz
,v01.tms_land_cd
,v01.sperr_fg
,v01.sammelbeleg_id
,v01.tms_standorttyp_id
,v03.dat_wanko_von
,v02.wup_standort AS lagernummer_bez
,v02.wup_standort AS lagernummer_bez_de
,v02.wup_standort AS lagernummer_bez_cz
,v02.wup_standort AS lagernummer_bez_sk
,v02.wup_standort AS lagernummer_bez_hr
,v02.wup_standort AS lagernummer_bez_pl
,v02.wup_standort AS lagernummer_bez_ro
,v02.wup_standort AS lagernummer_bez_bg
FROM dbp_view.v_tms_gp v01

JOIN dbp_view.v_L_SYSTEM sys 
ON sys.system_id=v01.system_id
AND LEFT(sys.SYSTEM_BEZ,4) = 'KTMS' AND LEFT(sys.KL_SYSTEM_BEZ,3)  <> 'FLW' 

JOIN dbp_view.v_wup v02
ON v01.mandant_id=v02.mandant_id
AND TRY_CAST(v01.tms_gp_id AS NUMBER) = v02.wup_id
AND v02.nb_id=-111

JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat_tms_wanko, DATE'9999-12-31')) AS dat_wanko_von FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM GROUP BY mandant_id, wup_id) v03 
ON v02.mandant_id=v03.mandant_id AND v02.wup_id=v03.wup_id 

JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat, DATE'9999-12-31')) AS dat_ewm_von FROM DBP_MSI_data.ts_lagerort_ewm_dat GROUP BY mandant_id, wup_id) v04
ON v02.mandant_id=v04.mandant_id AND v02.wup_id=v04.wup_id 

WHERE tms_gp_typ_cd='L' AND dat_wanko_von <= dat_ewm_von

UNION
SELECT --FLW
v01.mandant_id
,2 AS ewm_fg
,v01.tms_gp_id
,v01.tms_gp_id AS TMS_GP_ID_ANZEIGE
,v01.tms_gp_typ_cd
,v01.tms_gp_lfd_nr
,v01.tms_gp_name
,v01.tms_gp_altnv_name
,v01.tms_gp_strasse
,v01.tms_gp_ort_name
,v01.tms_gp_plz
,v01.tms_land_cd
,v01.sperr_fg
,v01.sammelbeleg_id
,v01.tms_standorttyp_id
,CASE WHEN v01.tms_gp_id = '6922' THEN DATE '2025-02-17' 
      WHEN v01.tms_gp_id = '6921' THEN DATE '2025-03-10' ELSE DATE '1900-01-01' END AS dat_wanko_von
,v01.tms_gp_name AS lagernummer_bez
,v01.tms_gp_name AS lagernummer_bez_de
,v01.tms_gp_name AS lagernummer_bez_cz
,v01.tms_gp_name AS lagernummer_bez_sk
,v01.tms_gp_name AS lagernummer_bez_hr
,v01.tms_gp_name AS lagernummer_bez_pl
,v01.tms_gp_name AS lagernummer_bez_ro
,v01.tms_gp_name AS lagernummer_bez_bg
FROM dbp_view.v_tms_gp v01

JOIN dbp_view.v_L_SYSTEM sys 
ON sys.system_id=v01.system_id
AND LEFT(sys.SYSTEM_BEZ,4) = 'KTMS' AND LEFT(sys.KL_SYSTEM_BEZ,3)  = 'FLW' 

WHERE tms_gp_id IN ('6921','6922') AND v01.tms_gp_typ_cd = 'L'
;