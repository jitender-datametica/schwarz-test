CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_UBERLAUFPALETTEN(
	WUP_ID,
	MANDANT_ID,
	NB_ID,
	LAGERNUMMER_ID,
	DAT_LIEF_SOLL,
	LIEF_PAL_TYP_ID,
	LIEF_TYP_ID,
	WERBEWARE_ID,
	WG_VERKETT_LIEF,
	WG_VERKETT_HIER_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_ORIG_ID,
	HU_ANZAHL,
	COUNT_PAL_TYP,
	VZ_WUP_ID,
	VZ_NB_ID,
	KKP_TYPE
) AS
-- AP0092670, SPEC0142675, dknop, changing condition from lb_split.split_vorgang_id is not null to lb_split.split_vorgang_id<>''
-- AP0092670, SPEC0142675, dknop,  correcting logic for hu_anzahl, lief_beleg_orig_id, kkp_type
-- 20221004,AP0092670, SPEC0142675, dknop, adding join to dbp_msi_data.ts_lagerort_ewm_dat and filter on dat_lief_soll instead of hardcoded DC/Dates
-- 20221007,AP0092670, SPEC0142675, dknop, adding condition for hu_anzahl hu_status_id = '0050', adding wg_verkett_hier_id
-- 20221007,AP0092670, SPEC0142675, dknop,updating logic for kkp_type - adding '0'
-- 20221122,AP0092670, SPEC0142675, dknop,exchange dat_lief_soll with dat_erstellung in joins
-- 20221128,AP0092670, SPEC0142675, dknop, correcting anzahl_hu
SELECT
 bl.wup_id
,bl.mandant_id
,bl.nb_id
,bl.lagernummer_id
,bl.dat_lief_soll
,bl.lief_pal_typ_id
,bl.lief_typ_id
,bl.werbeware_id
,bl.wg_verkett_lief
,CASE WHEN bl.wg_verkett_fg=1 THEN TO_CHAR(wgverper.wg_verkett_hier_id) ELSE '' END AS wg_verkett_hier_id
,bl.lief_beleg_id
,CASE WHEN lb_split.split_vorgang_id ='' THEN COALESCE (COALESCE(lb_split2.lief_beleg_split_id ,lb_split.lief_beleg_split_id), bl.lief_beleg_id) ELSE bl.lief_beleg_id END AS lief_beleg_orig_id
,SUM(hu_anzl.hu_anzahl) OVER (PARTITION BY bl.mandant_id, lief_beleg_orig_id, bl.kj)
,COUNT(DISTINCT bl.lief_pal_typ_id) OVER (PARTITION BY bl.mandant_id, lief_beleg_orig_id, bl.kj) AS count_pal_typ
,lag_num.wup_id AS vz_wup_id,
/* Damit das Attribut Verteilzentrum auch ein nb_id bekommt*/
-111 AS vz_nb_id
,CASE WHEN bl.wg_verkett_fg =0 THEN CASE WHEN wgver.klapp_pal_fg=1 AND (CASE WHEN wgver.palettengroesse_einh_id='CM' THEN wgver.palettenvolumen/1000
                                         ELSE wgver.palettenvolumen END)>800 THEN '2'
                                         WHEN wgver.klapp_pal_fg=0 AND (CASE WHEN wgver.palettengroesse_einh_id='CM' THEN wgver.palettenvolumen/1000
                                         ELSE wgver.palettenvolumen END)>800 THEN '0'
                                         ELSE '1' END
ELSE 										 
                                    CASE WHEN wupwgverhie.klapp_pal_fg=1 AND (CASE WHEN wupwgverhie.palettengroesse_einh_id='CM' THEN wupwgverhie.palettenvolumen/1000
                                         ELSE wupwgverhie.palettenvolumen END)>800 THEN '2' 
                                         WHEN wupwgverhie.klapp_pal_fg=0 AND (CASE WHEN wupwgverhie.palettengroesse_einh_id='CM' THEN wupwgverhie.palettenvolumen/1000
                                         ELSE wupwgverhie.palettenvolumen END)>800 THEN '0' 
                                         ELSE '1' END  END AS kkp_type
      
 FROM dbp_view.v_besch_lief bl

LEFT JOIN dbp_view.v_lief_belegfluss_split lb_split
ON  bl.mandant_id=lb_split.mandant_id
AND bl.lief_beleg_id=lb_split.lief_beleg_id
AND lb_split.split_vorgang_id ='' 

LEFT JOIN dbp_view.v_lief_belegfluss_split lb_split2
ON  lb_split.mandant_id=lb_split2.mandant_id
AND lb_split.lief_beleg_split_id=lb_split2.lief_beleg_id
AND lb_split2.split_vorgang_id ='' 

LEFT JOIN (SELECT 
  lief_beleg_id
  ,mandant_id
   ,kj_lief_beleg
  ,COUNT(DISTINCT handling_unit_id_ext) AS hu_anzahl FROM dbp_view.v_handling_unit
           WHERE hu_status_id = '0050'
      GROUP BY lief_beleg_id,kj_lief_beleg, mandant_id ) hu_anzl
                --ON   CASE WHEN lb_split.split_vorgang_id ='' THEN COALESCE (COALESCE(lb_split2.lief_beleg_split_id ,lb_split.lief_beleg_split_id), bl.lief_beleg_id) ELSE bl.lief_beleg_id END=hu_anzl.lief_beleg_id
                ON  bl.lief_beleg_id =hu_anzl.lief_beleg_id
                AND bl.mandant_id=hu_anzl.mandant_id
                AND bl.kj=hu_anzl.kj_lief_beleg
           


LEFT JOIN dbp_view.v_l_lagernummer lag_num
ON bl.mandant_id = lag_num.mandant_id
AND bl.lagernummer_id = lag_num.lagernummer_id

LEFT JOIN (SELECT 
            mandant_id
           ,wup_id
           ,nb_id
           ,lagernummer_id
           ,MIN(dat) AS dat 
           FROM dbp_msi_data.ts_lagerort_ewm_dat 
           GROUP BY mandant_id
           ,wup_id
           ,nb_id
           ,lagernummer_id) l_ewm
  ON bl.mandant_id = l_ewm.mandant_id
 AND lag_num.wup_id = l_ewm.wup_id
 AND lag_num.nb_id = l_ewm.nb_id
 AND bl.lagernummer_id = l_ewm.lagernummer_id
 
LEFT JOIN dbp_view.v_wg_verkettung_hierarchie_zu_per wgverper
ON  lag_num.wup_id = wgverper.wup_id 
AND bl.mandant_id=wgverper.mandant_id
AND bl.wg_verkett_lief= wgverper.wg_verkett_id
AND COALESCE (bl.dat_erstellung ,bl.dat_lief_soll) BETWEEN wgverper.dat_von AND wgverper.dat_bis
AND bl.wg_verkett_fg =1

LEFT JOIN  dbp_view.v_wg_verkettung_per wgver
ON  lag_num.wup_id =wgver.wup_id 
AND bl.mandant_id=wgver.mandant_id
AND bl.wg_verkett_lief=wgver.wg_verkett_id
AND COALESCE (bl.dat_erstellung ,bl.dat_lief_soll) BETWEEN wgver.dat_von AND wgver.dat_bis
AND bl.wg_verkett_fg =0

LEFT JOIN dbp_view.v_wup_wg_verkettung_hierarchie_per wupwgverhie 
ON  lag_num.wup_id=wupwgverhie.wup_id
AND bl.mandant_id=wupwgverhie.mandant_id
AND wgverper.wg_verkett_hier_id=wupwgverhie.wg_verkett_hier_id 
AND COALESCE (bl.dat_erstellung ,bl.dat_lief_soll) BETWEEN wupwgverhie.dat_von AND wupwgverhie.dat_bis
AND bl.wg_verkett_fg =1


WHERE -- EWM Lagernummern ausfiltern! - Erweiterung mit jedem Go-Live erforderlich!
( l_ewm.mandant_id IS NULL OR NOT  bl.dat_lief_soll >= l_ewm.dat) 
--and bl.wup_id=6905  and bl.dat_lief_soll='2022-09-03'

;

