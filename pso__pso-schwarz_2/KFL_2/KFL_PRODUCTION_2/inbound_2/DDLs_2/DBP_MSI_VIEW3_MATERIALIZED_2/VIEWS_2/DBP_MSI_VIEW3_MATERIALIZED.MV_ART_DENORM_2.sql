create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_ART_DENORM_2(
	MANDANT_ID,
	ART_ID,
	KL_ART_ID,
	ART_BEZ_DE,
	WAUSM,
	WG_ID,
	WG_BEZ,
	HWG_ID,
	HWG_BEZ,
	OWG_ID,
	OWG_BEZ,
	ABT_ID,
	ABT_BEZ,
	SORTIMENTSBEREICH_ID,
	SORTIMENTSBEREICH_BEZ_DE,
	SORTIMENTSGRUPPE_ID,
	SORTIMENTSGRUPPE_BEZ_DE
) as
--2024-05-14, dknop, initial
SELECT  
mara.mandant_id
, mara.art_id
, mara.kl_art_id
, makt.art_bez AS art_bez_de
, maw1.ausg_menge_einh_id AS wausm
, wg_spr.wg_id
, wg_spr.wg_bez
, hwg_per.hwg_id
, hwg_spr.hwg_bez
, owg_spr.owg_id
, owg_spr.owg_bez
, abt_spr.abt_id
, abt_spr.abt_bez 
  ,COALESCE(scm.WG_HIERARCHIE_MUTTER_ID,-1) AS sortimentsbereich_id
, scm_spr.WG_HIERARCHIE_bez AS sortimentsbereich_bez_de
,COALESCE(scmG.WG_HIERARCHIE_MUTTER_ID,-1) AS sortimentsgruppe_id
, scmG_spr.WG_HIERARCHIE_bez AS sortimentsgruppe_bez_de
FROM  dbp_data.art_2  mara_2               --  mara_2    
       JOIN  dbp_data.art_spr_zu_2  makt_2               --  makt_2
    ON  makt.mandant_id  =  mara.mandant_id
      AND  makt.art_id  =  mara.art_id
      AND makt.spr_id=22
 
JOIN dbp_data.art_vorschlagswert_per_2  maw1_2 
ON  maw1.mandant_id  =  mara.mandant_id 
      AND  maw1.art_id=mara.art_id
      AND   maw1.dat_bis = '9999-12-31'
 
JOIN   dbp_data.art_wg_zu_per_2  wg           --  art_wg_zu_per_2       
    ON  mara.mandant_id=wg.mandant_id 
      AND  mara.art_id=wg.art_id 
      AND    wg.dat_bis = '9999-12-31'
      AND  wg.arthiertyp_id  =  2
JOIN  dbp_data.wg_per_2  wg_per_2  --  wg_per_2
    ON  wg_per.mandant_id=wg.mandant_id
      AND wg_per.wg_id=wg.wg_id
      AND wg_per.dat_bis = '9999-12-31'
      AND wg_per.arthiertyp_id  =  2
 
      JOIN  dbp_data.wg_spr_zu_2  wg_spr  --  wg_per_2
    ON  wg_spr.mandant_id=wg.mandant_id
      AND wg_spr.wg_id=wg.wg_id
      AND wg_spr.spr_id=22
JOIN  dbp_data.owg_per_2  owg_per_2  --  owg_per_2
    ON    owg_per.mandant_id=mara.mandant_id AND wg_per.owg_id=owg_per.owg_id
      AND owg_per.dat_bis = '9999-12-31'
      AND owg_per.arthiertyp_id  =  2
 
      JOIN  dbp_data.hwg_per_2  hwg_per_2  --  hwg_per_2
    ON    hwg_per.mandant_id = mara.mandant_id 
    AND    hwg_per.hwg_id=owg_per.hwg_id
      AND   hwg_per.dat_bis = '9999-12-31'
      AND hwg_per.arthiertyp_id  =  2
 
            JOIN  dbp_data.owg_spr_zu_2  owg_spr  --  owg_spr
    ON   owg_spr.owg_id=owg_per.owg_id
    AND owg_spr.mandant_id = mara.mandant_id 
      AND owg_spr.spr_id=22
 
         JOIN  dbp_data.hwg_spr_zu_2  hwg_spr  --  owg_spr
    ON   hwg_spr.mandant_id = mara.mandant_id AND
    hwg_spr.hwg_id=owg_per.hwg_id
      AND hwg_spr.spr_id=22
 
        JOIN  dbp_data.abt_spr_zu_2  abt_spr  --  abt_spr
    ON  abt_spr.mandant_id=hwg_per.mandant_id
AND abt_spr.abt_id =hwg_per.abt_id
AND abt_spr.spr_id=22
 
LEFT JOIN dbp_view.v_WG_HIERARCHIE_ZU_PER_2 scm
ON hwg_per.mandant_id=scm.mandant_id
AND hwg_per.hwg_id=scm.WG_HIERARCHIE_ID
AND scm.ARTHIERTYP_ID=13
 
LEFT JOIN dbp_view.v_WG_HIERARCHIE_SPR_ZU_2 scm_spr
ON scm.mandant_id=scm_spr.mandant_id
AND scm.WG_HIERARCHIE_MUTTER_ID=scm_spr.WG_HIERARCHIE_ID
AND scm_spr.ARTHIERTYP_ID=13
AND scm_spr.spr_id=22
 
LEFT JOIN dbp_view.v_WG_HIERARCHIE_ZU_PER_2 scmG
ON wg_per.mandant_id=scmG.mandant_id
AND wg_per.wg_id=scmG.WG_HIERARCHIE_ID
AND scmG.ARTHIERTYP_ID=11
 
LEFT JOIN dbp_view.v_WG_HIERARCHIE_SPR_ZU_2 scmG_spr
ON scmG.mandant_id=scmG_spr.mandant_id
AND scmG.WG_HIERARCHIE_MUTTER_ID=scmG_spr.WG_HIERARCHIE_ID
AND scmG_spr.ARTHIERTYP_ID=11
AND scmG_spr.spr_id=22;