CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TRANSPORTAUFTRAG_DET (
	ART_ID,
	LAGERNUMMER_ID,
	LAGERORT_ID,
	MANDANT_ID,
	NACH_LAGERTYP_ID,
	NACH_LAGERPLATZ_ID,
	NB_ID,
	TRANSPORT_BELEG_ID,
	TRANSPORT_BELEG_POS_ID,
	GLOBAL_VON_LAGERTYP_ID,
	VON_LAGERTYP_ID,
	VON_LAGERPLATZ_ID,
	WUP_ID,
	DAT_ERSTELLUNG,
	DAT_QUITTIERUNG,
	ZEIT_QUITTIERUNG,
	QUITTIERUNG_DT,
	MENGE_TRANSPORTAUFTRAG_KOLLI,
	DAT_ENTNAHME_QUITTIERUNG,
	ZEIT_ENTNAHME_QUITTIERUNG,
	ENTNAHME_QUITTIERUNG_DT,
	LAGER_EINHEIT_ID_VON,
	LAGER_EINHEIT_ID_NACH,
	MENGE_IST_NACH,
	MENGE_SOLL_VON,
	STATUS_QUITTIERUNG,
	LAGER_EINHEITEN_TYP,
	TRANSPORT_VORGANG_ID,
	DAT_VERFALL,
	BRUTTOGEW_KG,
	NACHSCHUBZEIT_SEKUNDEN,
	PLATZ_LEER_FG,
	MENGE_SOLL_NACH_ALTNV,
	MIN_NACHSCHUB_KDR,
	DISTANZ,
	MENGE_IST,
	EINL_EBENE,
	SAP_USER,
	USER_FLAG,
	HANDLING_UNIT_ID_EXT,
	PICK_TYPE_ID
)
AS
--04.05.2015 twie: neues Feld einl_ebene
--21.06.2017 hmue: neues Feld 'sap_user'
--21.06.2017 hmue: Flag anlegen -> (1 für Benutzer = ZBATCHANBRNS, Else 0). siehe user_flag und sap_user
--2022-10-18, AP0149040_SPEC0173503, dknop, adding pick_type_id logic
--2022-11-18, AP0149040_SPEC0173503, dknop, updates to pick_type_id logic
SELECT

    ltap.art_id,
    ltap.lagernummer_id,
    ltap.lagerort_id,
    ltap.mandant_id,
    ltap.nach_lagertyp_id,
    ltap.nach_lagerplatz_id,
    ltap.nb_id,
    ltap.transport_beleg_id,
    ltap.transport_beleg_pos_id,
    CASE
        WHEN SUBSTR(ltap.von_lagertyp_id, 1, 2) = 'R0' THEN 'Regal Erdgeschoss'
        WHEN SUBSTR(ltap.von_lagertyp_id, 1, 2) = 'R1' THEN 'Regal Obergeschoss'
        WHEN ltap.von_lagertyp_id = 'H01' THEN 'Hochregal'
        WHEN ltap.von_lagertyp_id IN ('RH1', 'RT1') THEN 'AKL-Hochregal'
        ELSE 'Sonstige'
    END global_von_lagertyp_id,
    ltap.von_lagertyp_id,
    ltap.von_lagerplatz_id,
    ltap.wup_id,
    ltap.dat_erstellung,
    ltap.dat_quittierung,
    ltap.zeit_quittierung,
    TIMESTAMP_FROM_PARTS(ltap.dat_quittierung, COALESCE(ltap.zeit_quittierung,'00:00:00')) AS quittierung_dt,
    ltap.menge_transportauftrag_kolli,
    ltap.dat_entnahme_quittierung,
    ltap.zeit_entnahme_quittierung,
    TIMESTAMP_FROM_PARTS(ltap.dat_entnahme_quittierung, COALESCE(ltap.zeit_entnahme_quittierung,'00:00:00')) AS entnahme_quittierung_dt,
    ltap.lager_einheit_id_von,
    ltap.lager_einheit_id_nach,
    ltap.menge_ist_nach,
    ltap.menge_soll_von,
    /** alter Zweig **
     CASE WHEN quittierung_fg = 1 AND menge_soll_von = menge_ist_nach
     THEN 'voll quittiert'
     WHEN quittierung_fg = 1 AND menge_soll_von > menge_ist_nach
     THEN 'teil quittiert'
     WHEN quittierung_fg = 1 AND transport_vorgang_id IN ('st', 'sl')
     THEN 'storniert'
     WHEN quittierung_fg = 0
     THEN 'offen'
     ELSE 'sonstiges'
     END   AS status_quittierung
     **/
    -- Änderung lt. Mail vom 18.07.2013
    CASE
        WHEN ltap.quittierung_fg = 1
        AND (
            ltap.menge_soll_von = ltap.menge_ist_nach
            OR (
                ltap.menge_soll_von = 0
                AND ltap.menge_ist_nach > 0
            )
        )
        AND COALESCE(ltap.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'voll quittiert'
        WHEN ltap.quittierung_fg = 1
        AND ltap.menge_soll_von > ltap.menge_ist_nach
        AND COALESCE(ltap.transport_vorgang_id, '') NOT IN ('st', 'sl') THEN 'teil quittiert'
        WHEN ltap.quittierung_fg = 1
        AND ltap.transport_vorgang_id IN ('st', 'sl') THEN 'storniert'
        WHEN ltap.quittierung_fg = 0 THEN 'offen'
        ELSE 'sonstiges'
    END :: VARCHAR(14) AS status_quittierung,
    --Anf 584954
    ltap.lager_einheiten_typ,
    ltap.transport_vorgang_id,
    ltap.dat_verfall,
    ltap.bruttogew_kg,
    ltap.nachschubzeit_sekunden,
    ltap.platz_leer_fg,
    ltap.menge_soll_nach_altnv,
    ltap.min_nachschub_kdr,
    ltap.distanz,
    CASE
        WHEN ltap.menge_soll_von <> 0 THEN menge_soll_von
        ELSE ltap.menge_ist_nach
    END AS menge_ist,
    ltap.einl_ebene,
    ltap.sap_user,
    CASE
        WHEN ltap.sap_user = 'ZBATCHANBRNS' THEN 1
        ELSE 0
    END AS user_flag,
    ltap.handling_unit_id_ext,
    CASE
       WHEN ltap.transport_vorgang_id = 'LF' AND ltap.platz_leer_fg = 0 THEN 1 --pick all
       WHEN ltap.transport_vorgang_id = 'LF' AND ltap.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos = 1 THEN 2  --skip+pick all
       WHEN ltap.transport_vorgang_id = 'SP' AND ltap.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos > 1 THEN 3 -- skip+pick part
       WHEN ltap.transport_vorgang_id = 'LF' AND ltap.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos > 1 THEN 4 -- pick rest
       WHEN ltap.transport_vorgang_id = 'ST' AND ltap.platz_leer_fg = 1 AND ltap_agg_fg0.anz_pos >= 1 AND ltap_agg_fg0.dist_vor = 1 THEN 5 --skip + storno
       WHEN ltap.transport_vorgang_id = 'ST' AND ltap.platz_leer_fg = 1 AND ltap_agg_st_sp.anz_pos > 1 AND ltap_agg_st_sp.dist_vor>1 THEN 6 --storno after pick part
       WHEN ltap.transport_vorgang_id = 'ST' AND ltap.platz_leer_fg = 0 THEN 7 --storno general AS pick_type_id 
       WHEN ltap.transport_vorgang_id IN ('SP') AND ltap.platz_leer_fg = 0 AND ltap_agg_lf_sp.anz_pos>1 THEN 8  --pick part (without skip confirmation) 
       WHEN ltap.transport_vorgang_id IN ('SP') AND ltap.platz_leer_fg = 0 AND ltap_agg_st_sp.anz_pos>1 THEN 9 --pick part (without skip confirmation) + storno
       WHEN ltap.transport_vorgang_id = '' THEN 10 -- kein Transportvorgang
       ELSE 0 END AS pick_type_id
FROM dbp_view.v_transportauftrag_det ltap

LEFT JOIN (SELECT 
           mandant_id, 
           wup_id, 
           transport_beleg_id,
           art_id,
           COUNT(*) AS anz_pos,
           COUNT(DISTINCT transport_vorgang_id) AS dist_vor
           FROM dbp_view.v_transportauftrag_det WHERE TRANSPORT_VORGANG_ID IN ('SP','LF','ST')
           AND NOT (transport_vorgang_id IN ('LF', 'ST') AND platz_leer_fg = 0 )
           GROUP BY mandant_id, wup_id, transport_beleg_id, art_id) ltap_agg_fg0
  ON   ltap.mandant_id = ltap_agg_fg0.mandant_id
 AND ltap.transport_beleg_id = ltap_agg_fg0.transport_beleg_id
 AND ltap.art_id = ltap_agg_fg0.art_id
 AND ltap.wup_id=ltap_agg_fg0.wup_id


 LEFT JOIN (SELECT 
           mandant_id, 
           wup_id, 
           transport_beleg_id,
           art_id,
           COUNT(*) AS anz_pos
           FROM dbp_view.v_transportauftrag_det 
           WHERE (transport_vorgang_id IN ('LF', 'SP'))
           GROUP BY mandant_id, wup_id, transport_beleg_id, art_id) ltap_agg_lf_sp
  ON   ltap.mandant_id = ltap_agg_lf_sp.mandant_id
 AND ltap.transport_beleg_id = ltap_agg_lf_sp.transport_beleg_id
 AND ltap.art_id = ltap_agg_lf_sp.art_id
 AND ltap.wup_id=ltap_agg_lf_sp.wup_id
 
LEFT JOIN (SELECT  
           mandant_id,  
           wup_id,  
           transport_beleg_id, 
           art_id, 
           COUNT(*) AS anz_pos ,
           COUNT(DISTINCT transport_vorgang_id) AS dist_vor
           FROM dbp_view.v_transportauftrag_det  
           WHERE (transport_vorgang_id IN ('ST', 'SP') ) 
           GROUP BY mandant_id, wup_id, transport_beleg_id, art_id) ltap_agg_st_sp 
  ON   ltap.mandant_id = ltap_agg_st_sp.mandant_id 
AND ltap.transport_beleg_id = ltap_agg_st_sp.transport_beleg_id 
AND ltap.art_id = ltap_agg_st_sp.art_id 
AND ltap.wup_id=ltap_agg_st_sp.wup_id 
 
WHERE EXTRACT(YEAR FROM dat_erstellung) >= YEAR(CURRENT_TIMESTAMP) - 2 --and ltap.transport_beleg_id=137189988  and ltap.art_id=94372200
;