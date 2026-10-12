
INSERT INTO ${TEMP_TABLE} /*DBP_ETL.art_gp_wup_bnk_zu_per_tmp_1*/
(
system_id
,mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,dat_von
,einkaufsorganisation_id
,dat_bis
,cycle_id
,betrag_auslandsfracht
,betrag_auslandsfracht2
,betrag_zoll
,betrag_antidump
,betrag_inlandsfracht
,betrag_gem_rueckn
,betrag_duales_system
,betrag_gema
,betrag_verbrauchsst
,betrag_verpackung
,betrag_prov
,betrag_hk_prov
,betrag_agentur_prov
,betrag_mto
,betrag_pruefkosten
,betrag_eu_regelung
,betrag_sonst_kosten
,kond_einh_id
)
SELECT
 7 AS system_id_l
,1 AS mandant_id_l
,a.art_id  AS art_id_l
,l.lifnr   AS gp_id_l
,CASE WHEN werks = '' THEN -1 ELSE w.wup_id END wup_id_l
,CASE WHEN werks = '' THEN NULL ELSE w.nb_id END nb_id_l
,CASE WHEN l.datab = '00000000'
THEN to_date('20020101','YYYYMMDD') /*CAST('20020101' AS DATE FORMAT 'YYYYMMDD')*/
ELSE to_date(l.datab,'YYYYMMDD') /*CAST(l.datab AS DATE FORMAT 'YYYYMMDD')*/
END AS dat_von_l
,g.einkaufsorganisation_id AS  einkaufsorganisation_id_l
,to_date('99991231','YYYYMMDD') /*CAST('99991231' AS DATE FORMAT 'YYYYMMDD') AS dat_bis_l*/
,823610 AS cycle_id_l
,CASE WHEN POSITION( '.' IN l.afracht1) > 1
THEN CAST (CAST (l.afracht1 AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.afracht1 AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_auslandsfracht_l
,CASE WHEN POSITION( '.' IN l.afracht2) > 1
THEN CAST (CAST (l.afracht2 AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.afracht2 AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_auslandsfracht2_l
,CASE WHEN POSITION( '.' IN l.zoll) > 1
THEN CAST (CAST (l.zoll AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.zoll AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_zoll_l
,CASE WHEN POSITION( '.' IN l.antidump) > 1
THEN CAST (CAST (l.antidump AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.antidump AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_antidump_l
,CASE WHEN POSITION( '.' IN l.ifracht) > 1
THEN CAST (CAST (l.ifracht AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.ifracht AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_inlandsfracht_l
,CASE WHEN POSITION( '.' IN l.grs) > 1
THEN CAST (CAST (l.grs AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.grs AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_gem_rueckn_l
,CASE WHEN POSITION( '.' IN l.dsd) > 1
THEN CAST (CAST (l.dsd AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.dsd AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_duales_system_l
,CASE WHEN POSITION( '.' IN l.gema) > 1
THEN CAST (CAST (l.gema AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.gema AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_gema_l
,CASE WHEN POSITION( '.' IN l.vsteuer) > 1
THEN CAST (CAST (l.vsteuer AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.vsteuer AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_verbrauchsst_l
,CASE WHEN POSITION( '.' IN l.verpack) > 1
THEN CAST (CAST (l.verpack AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.verpack AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_verpackung_l
,CASE WHEN POSITION( '.' IN l.prov) > 1
THEN CAST (CAST (l.prov AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.prov AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_prov_l
,CASE WHEN POSITION( '.' IN l.hkprov) > 1
THEN CAST (CAST (l.hkprov AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.hkprov AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_hk_prov_l
,CASE WHEN POSITION( '.' IN l.anprov) > 1
THEN CAST (CAST (l.anprov AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.anprov AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_agentur_prov_l
,CASE WHEN POSITION( '.' IN l.mto) > 1
THEN CAST (CAST (l.mto AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.mto AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_mto_l
,CASE WHEN POSITION( '.' IN l.pruefk) > 1
THEN CAST (CAST (l.pruefk AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.pruefk AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_pruefkosten_l
,CASE WHEN POSITION( '.' IN l.euregel) > 1
THEN CAST (CAST (l.euregel AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.euregel AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_eu_regelung_l
,CASE WHEN POSITION( '.' IN l.sonstige) > 1
THEN CAST (CAST (l.sonstige AS FLOAT) * 1000  AS DECIMAL (9,4))
ELSE CAST (CAST (l.sonstige AS FLOAT) / 10000 AS DECIMAL (9,4))
END AS betrag_sonst_kosten_l
,SUBSTRING(l.konwa, 1, 3) AS kond_einh_id_l
FROM DBP_ETL.zbnk_1 l
INNER JOIN
(
SELECT
MAX(art_id) as art_id
,mandant_id
,kl_art_id
FROM DBP_DATA.art_1
GROUP BY 2,3
) a
ON a.kl_art_id = l.matnr
AND a.mandant_id = 1
LEFT OUTER JOIN DBP_DATA.wup_1 w
ON w.wup_id = TRIM(l.werks)
AND w.mandant_id = 1
INNER JOIN DBP_DATA.gp_1 g
ON g.gp_id=CAST(l.lifnr AS INTEGER)
AND g.mandant_id = 1
AND g.einkaufsorganisation_id=1000
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_gp_wup_bnk_zu_per_1 t1_1
WHERE EXISTS
(
SELECT
*
FROM /*DBP_ETL.art_gp_wup_bnk_zu_per_tmp_1*/ dt1

WHERE dt1.system_id               = t1.system_id
AND dt1.mandant_id              = t1.mandant_id
AND dt1.art_id                  = t1.art_id
AND dt1.gp_id                   = t1.gp_id
AND dt1.wup_id                  = t1.wup_id
AND dt1.einkaufsorganisation_id = t1.einkaufsorganisation_id
AND t1.dat_von                 >= dt1.dat_von
AND 0                    = 0
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM ${TEMP_TABLE} /*DBP_ETL.art_gp_wup_bnk_zu_per_tmp_1*/ t1_1
WHERE EXISTS
(
SELECT
*
FROM DBP_DATA.art_gp_wup_bnk_zu_per_1 dt1
WHERE dt1.mandant_id = t1.mandant_id
AND dt1.art_id     = t1.art_id
AND dt1.gp_id      = t1.gp_id
AND dt1.wup_id     = t1.wup_id
AND dt1.dat_von   <= t1.dat_von
AND 0       = 1
)
;


INSERT INTO DBP_DATA.art_gp_wup_bnk_zu_per_1
(
system_id
,mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,dat_von
,einkaufsorganisation_id
,dat_bis
,cycle_id
,betrag_auslandsfracht
,betrag_auslandsfracht2
,betrag_zoll
,betrag_antidump
,betrag_inlandsfracht
,betrag_gem_rueckn
,betrag_duales_system
,betrag_gema
,betrag_verbrauchsst
,betrag_verpackung
,betrag_prov
,betrag_hk_prov
,betrag_agentur_prov
,betrag_mto
,betrag_pruefkosten
,betrag_eu_regelung
,betrag_sonst_kosten
,kond_einh_id
)
SELECT
system_id
,mandant_id
,art_id
,gp_id
,wup_id
,nb_id
,dat_von
,einkaufsorganisation_id
,dat_bis
,cycle_id
,betrag_auslandsfracht
,betrag_auslandsfracht2
,betrag_zoll
,betrag_antidump
,betrag_inlandsfracht
,betrag_gem_rueckn
,betrag_duales_system
,betrag_gema
,betrag_verbrauchsst
,betrag_verpackung
,betrag_prov
,betrag_hk_prov
,betrag_agentur_prov
,betrag_mto
,betrag_pruefkosten
,betrag_eu_regelung
,betrag_sonst_kosten
,kond_einh_id
FROM ${TEMP_TABLE}  /*DBP_ETL.art_gp_wup_bnk_zu_per_tmp_1*/
;


UPDATE DBP_DATA.art_gp_wup_bnk_zu_per_1
SET dat_bis = dt1.dat_bis
FROM
(
SELECT
system_id
,mandant_id
,art_id
,gp_id
,einkaufsorganisation_id
,wup_id
,nb_id
,dat_von
/*,CASE WHEN (MSUM(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) = 0
THEN to_date('9999-12-31','YYYY-MM_1-DD')
ELSE CAST((MSUM(CAST(dat_von AS INTEGER), 2, dat_von desc) - CAST(dat_von AS INTEGER)) AS DATE) -1
END AS dat_bis*/
--mfialkiewicz
,CASE
   WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY system_id, mandant_id, gp_id, einkaufsorganisation_id, art_id, wup_id, nb_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0 THEN TO_DATE('9999-12-31','YYYY-MM_1-DD')
    ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY system_id, mandant_id, gp_id, einkaufsorganisation_id, art_id, wup_id, nb_id  ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD')))),'YYYYMMDD'))
   END AS DAT_BIS
FROM DBP_DATA.art_gp_wup_bnk_zu_per_1
--GROUP BY system_id, mandant_id, gp_id, einkaufsorganisation_id, art_id, wup_id, nb_id
) dt1 WHERE DBP_DATA.art_gp_wup_bnk_zu_per.system_id               =  dt1.system_id
AND DBP_DATA.art_gp_wup_bnk_zu_per.mandant_id              =  dt1.mandant_id
AND DBP_DATA.art_gp_wup_bnk_zu_per.art_id                  =  dt1.art_id
AND DBP_DATA.art_gp_wup_bnk_zu_per.gp_id                   =  dt1.gp_id
AND DBP_DATA.art_gp_wup_bnk_zu_per.einkaufsorganisation_id =  dt1.einkaufsorganisation_id
AND DBP_DATA.art_gp_wup_bnk_zu_per.wup_id                  =  dt1.wup_id
AND COALESCE(DBP_DATA.art_gp_wup_bnk_zu_per.nb_id, -999)   =  COALESCE(dt1.nb_id, -999)
AND DBP_DATA.art_gp_wup_bnk_zu_per.dat_von                 =  dt1.dat_von
AND DBP_DATA.art_gp_wup_bnk_zu_per.dat_bis                 <> dt1.dat_bis
;

