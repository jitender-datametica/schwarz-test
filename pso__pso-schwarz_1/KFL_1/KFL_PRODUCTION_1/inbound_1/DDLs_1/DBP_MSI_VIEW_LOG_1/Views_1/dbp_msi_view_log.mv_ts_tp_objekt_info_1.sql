CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TS_TP_OBJEKT_INFO_1(
	MANDANT_ID,
	TP_OBJEKT_ID,
	GEBAEUDE_ID,
	GEBAEUDE_BEZ,
	ANLAGE_ID,
	ANLAGE_BEZ,
	ANLAGENGRUPPE_ID,
	ANLAGENGRUPPE_BEZ,
	ANLAGENTEIL_ID,
	ANLAGENTEIL_BEZ
) AS
-- AP0133256_SPEC0166769, dknop, initial
--2023-05-25, removing duplicates when anlage_bez='' instead of anlage_bez is NULL
--2023-07-21, dknop, adding fixed value for anlage_1 when tp_objekt_typ='3'
--2024-04-03, dknop, adding fixed value for anlage_1 when tp_objekt_typ='7'
--2024-06-04, dknop, removing duplicates when anlage_bez='-' instead of anlage_bez is NULL
SELECT
 v1.mandant_id
,v1.tp_objekt_id
--,(COALESCE(v2.tp_objekt_typ,'')) AS tp_objekt_typ
,MAX(COALESCE(NULLIF(v2.gebaeude_bez,''),'-1')) AS gebaeude_id
,MAX(COALESCE(NULLIF(v2.gebaeude_bez,''),'')) AS gebaeude_bez
,MAX(CASE WHEN v1.tp_objekt_typ='3' THEN 'FFZ' 
          WHEN v1.tp_objekt_typ = '7' THEN 'Reinigung' 
          ELSE COALESCE(NULLIF(v2.anlage_bez,''),'-1') 
     END) AS anlage_id
,MAX(CASE WHEN v1.tp_objekt_typ='3' THEN 'FFZ' 
          WHEN v1.tp_objekt_typ = '7' THEN 'Reinigung' 
          ELSE COALESCE(NULLIF(v2.anlage_bez,''),'') 
     END) AS anlage_bez
,MAX(COALESCE(CASE WHEN v2.anlagengruppe_bez = '' OR v2.anlagengruppe_bez = '-' THEN NULL
                   ELSE v2.anlagengruppe_bez END ,'-1')) AS anlagengruppe_id
,MAX(COALESCE(CASE WHEN v2.anlagengruppe_bez = '' OR v2.anlagengruppe_bez = '-' THEN NULL
                   ELSE v2.anlagengruppe_bez END ,'')) AS anlagengruppe_bez
,MAX(COALESCE(CASE WHEN v2.anlagenteil_bez = '' OR v2.anlagenteil_bez = '-' THEN NULL
                   ELSE v2.anlagenteil_bez END ,'-1')) AS anlagenteil_id
,MAX(COALESCE(CASE WHEN v2.anlagenteil_bez = '' OR v2.anlagenteil_bez = '-' THEN NULL
                   ELSE v2.anlagenteil_bez END,'')) AS anlagenteil_bez
FROM dbp_view.v_tp_objekt_per_1 v1
LEFT JOIN dbp_msi_view_log.v_ts_tp_objekt_info_1 v2
ON v1.mandant_id=v2.mandant_id
AND v1.tp_objekt_id=v2.tp_objekt_id
AND v1.dat_bis='9999-12-31'


GROUP BY v1.mandant_id,
v1.tp_objekt_id


;