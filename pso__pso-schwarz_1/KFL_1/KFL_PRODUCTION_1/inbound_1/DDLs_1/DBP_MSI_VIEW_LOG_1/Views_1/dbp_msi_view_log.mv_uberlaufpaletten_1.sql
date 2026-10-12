CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_UBERLAUFPALETTEN_1(
	MANDANT_ID,
	LAGERNUMMER_ID,
	ARTIKELSORTIMENT_ID,
	DAT_LIEF_SOLL,
	LIEF_PAL_TYP_ID,
	LIEF_TYP_ID,
	WERBEWARE_ID,
	WG_VERKETT_LIEF,
	WG_VERKETT_HIER_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_ORIG_ID,
	HU_ANZAHL,
	PAL_TYP_ANZAHL,
	KKP_TYPE
) AS
-- AP0117740, SPEC0141767, dknop, changing condition from lb_split.split_vorgang_id is not null to lb_split.split_vorgang_id<>''
-- AP0117740, SPEC0141767, dknop, correcting logic for hu_anzahl, lief_beleg_orig_id, kkp_type
-- 20221007,AP0117740, SPEC0141767, dknop, adding condition for hu_anzahl hu_status_id = '0020', adding wg_verkett_hier_id
-- 20221018,AP0117740, SPEC0141767, dknop, adding count_pal_typ
-- 20221201,AP0117740, SPEC0141767, dknop,exchange dat_lief_soll with dat_erstellung in joins
-- 20241119, nwag, map 5to1 (because of D070)
-- 20241209, nwag, fix typo
-- 20250331, nwag, typcast fix
SELECT
 hu_wa.mandant_id                                                              
,hu_wa.lagernummer_id
,CASE WHEN hu_wa.lagersortiment_id = '5' THEN '1' ELSE hu_wa.lagersortiment_id END AS artikelsortiment_id
,hu_wa.dat_lief_soll
,hu_wa.lief_pal_typ_id
,hu_wa.lief_typ_id
,hu_wa.werbeware_id
,hu_wa.wg_verkett_lief
,MAX(CASE WHEN hu_wa.wg_verkett_fg=1 THEN CAST(wgver.wg_verkett_hier_id AS CHAR(4)) ELSE '' END) AS wg_verkett_hier_id
,hu_wa.lief_beleg_id
,CASE WHEN lb_split.split_vorgang_id='' THEN COALESCE (COALESCE(lb_split2.lief_beleg_split_id ,lb_split.lief_beleg_split_id), hu_wa.lief_beleg_id) ELSE hu_wa.lief_beleg_id END AS lief_beleg_orig_id
,SUM(hu_anzl.hu_anzahl) OVER (PARTITION BY hu_wa.mandant_id, lief_beleg_orig_id) AS hu_anzahl
,COUNT(DISTINCT hu_wa.lief_pal_typ_id) OVER (PARTITION BY hu_wa.mandant_id, lief_beleg_orig_id) AS count_pal_typ
,CASE WHEN hu_wa.wg_verkett_fg =0 THEN CASE WHEN wgverper.klapp_pal_fg=1 AND (CASE WHEN wgverper.palettengroesse_einh_id='CM' THEN wgverper.palettenvolumen/1000
                                         ELSE wgverper.palettenvolumen END)>800 THEN '2'
                                         WHEN wgverper.klapp_pal_fg=0 AND (CASE WHEN wgverper.palettengroesse_einh_id='CM' THEN wgverper.palettenvolumen/1000
                                         ELSE wgverper.palettenvolumen END)>800 THEN '0'
                                         ELSE '1' END
ELSE 										 
                                    CASE WHEN wupwgverhie.klapp_pal_fg=1 AND (CASE WHEN wupwgverhie.palettengroesse_einh_id='CM' THEN wupwgverhie.palettenvolumen/1000
                                         ELSE wupwgverhie.palettenvolumen END)>800 THEN '2' 
                                         WHEN wupwgverhie.klapp_pal_fg=0 AND (CASE WHEN wupwgverhie.palettengroesse_einh_id='CM' THEN wupwgverhie.palettenvolumen/1000
                                         ELSE wupwgverhie.palettenvolumen END)>800 THEN '0' 
                                         ELSE '1' END  END AS kkp_type
      
 FROM dbp_view.v_besch_lief_wa_hu_sum_1 hu_wa

           
      
LEFT JOIN dbp_view.v_lief_belegfluss_split_1 lb_split
ON  hu_wa.mandant_id=lb_split.mandant_id
AND hu_wa.lief_beleg_id=lb_split.lief_beleg_id
AND lb_split.split_vorgang_id ='' 

LEFT JOIN dbp_view.v_lief_belegfluss_split_1 lb_split2
ON  lb_split.mandant_id=lb_split2.mandant_id
AND lb_split.lief_beleg_split_id=lb_split2.lief_beleg_id
AND lb_split2.split_vorgang_id ='' 

JOIN (SELECT 
  lief_beleg_id
  ,mandant_id
  ,COUNT(DISTINCT handling_unit_id_ext) AS hu_anzahl FROM dbp_view.v_handling_unit_1
      WHERE hu_status_id = '0020'
      GROUP BY lief_beleg_id, mandant_id) hu_anzl
                ON  hu_wa.mandant_id=hu_anzl.mandant_id
                AND hu_wa.lief_beleg_id=hu_anzl.lief_beleg_id
                
				
LEFT JOIN dbp_view.v_wg_verkettung_per_1 wgverper 
ON  hu_wa.wup_id = wgverper.wup_id 
AND hu_wa.mandant_id=wgverper.mandant_id
AND hu_wa.wg_verkett_lief= wgverper.wg_verkett_id
AND COALESCE (hu_wa.dat_erstellung ,hu_wa.dat_lief_soll) BETWEEN wgverper.dat_von AND wgverper.dat_bis
AND hu_wa.wg_verkett_fg = 0

LEFT JOIN  dbp_view.v_wg_verkettung_hierarchie_zu_per_1 wgver 
ON  hu_wa.wup_id =wgver.wup_id 
AND hu_wa.mandant_id=wgver.mandant_id
AND hu_wa.wg_verkett_lief=wgver.wg_verkett_id
AND COALESCE (hu_wa.dat_erstellung ,hu_wa.dat_lief_soll) BETWEEN wgver.dat_von AND wgver.dat_bis
AND hu_wa.wg_verkett_fg = 1

LEFT JOIN dbp_view.v_wup_wg_verkettung_hierarchie_per_1 wupwgverhie 
ON  wgver.wup_id=wupwgverhie.wup_id
AND wgver.mandant_id=wupwgverhie.mandant_id
AND wgver.wg_verkett_hier_id=wupwgverhie.wg_verkett_hier_id
AND COALESCE (hu_wa.dat_erstellung ,hu_wa.dat_lief_soll) BETWEEN wupwgverhie.dat_von AND wupwgverhie.dat_bis
AND hu_wa.wg_verkett_fg = 1
 --where
--mandant_id = 1 and dat_lief_soll='2022-08-02'
GROUP BY
 hu_wa.mandant_id                                                              
,hu_wa.lagernummer_id
,hu_wa.lagersortiment_id
,hu_wa.dat_lief_soll
,hu_wa.lief_pal_typ_id
,hu_wa.lief_typ_id
,hu_wa.werbeware_id
,hu_wa.wg_verkett_lief
,hu_wa.lief_beleg_id
,lief_beleg_orig_id
,hu_anzahl
,kkp_type
;