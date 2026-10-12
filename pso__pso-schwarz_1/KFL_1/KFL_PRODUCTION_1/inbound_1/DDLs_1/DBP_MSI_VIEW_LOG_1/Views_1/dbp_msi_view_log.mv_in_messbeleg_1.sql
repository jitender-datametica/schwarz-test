CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_MESSBELEG_1(
	MANDANT_ID,
	MESSBELEG_ID,
	MESSBELEG_BEZ,
	--AUFTRAG_ID,
	--AUFTRAG_NR,
	MESSPUNKT_ID,
	MESSPUNKT_BEZ,
	MESSWERT,
	MENGE_EINH_ID_MESSUNG,
	DAT_MESSUNG,
	TP_OBJEKT_ID
) AS
--2022-08-29, AP0133256,SPEC0166769,dknop, initial
--2023-01-09, AP0133256,SPEC0166769,dknop, adding tp_objekt_id and join to v_in_messpunkt_1
--2023-02-14,  AP0133256,SPEC0166769,dknop, removing 'WHERE auftrag_nr <>' for in_mess_agg, removing auftrag_id

SELECT 
 in_mess.mandant_id
,in_mess.messbeleg_id
,TO_CHAR(in_mess.messbeleg_id) AS messbeleg_bez
--,in_mess.auftrag_id
--,in_mess.auftrag_nr
,in_mess.messpunkt_id
,TO_CHAR(in_mess.messpunkt_id) AS messpunkt_bez
,in_mess.messwert
,in_mess.menge_einh_id_messung
,in_mess_agg.dat_messung AS dat_messung
,in_punkt.tp_objekt_id
FROM  dbp_view.v_in_messbeleg_1 in_mess

JOIN (SELECT mandant_id,messpunkt_id, MAX(messbeleg_id) AS messbeleg_id , MAX(dat_messung) AS dat_messung
      FROM dbp_view.v_in_messbeleg_1
      
     GROUP BY mandant_id, messpunkt_id 
     )in_mess_agg
      ON in_mess.mandant_id=in_mess_agg.mandant_id
      AND in_mess.messpunkt_id=in_mess_agg.messpunkt_id
      AND in_mess.messbeleg_id=in_mess_agg.messbeleg_id

LEFT JOIN dbp_view.v_in_messpunkt_1 in_punkt
    ON in_mess.messpunkt_id = in_punkt.messpunkt_id
    AND in_mess.mandant_id = in_punkt.mandant_id

UNION
               
SELECT
 mandant_id
,-1 AS messbeleg_id
,'N/A' AS messbeleg_bez
--,auftrag_id
--,'-1' AS auftrag_nr
,-1 AS messpunkt_id
,'N/A' AS messpunkt_bez
,NULL AS messwert
,NULL AS menge_einh_id_messung
,NULL AS dat_messung
,tp_objekt_id   
FROM dbp_view.v_tp_objekt_per_1 tp_ob
WHERE (tp_objekt_id,mandant_id) NOT IN (SELECT in_punkt.tp_objekt_id,in_punkt.mandant_id FROM dbp_view.v_in_messbeleg_1 in_mess

JOIN dbp_view.v_in_messpunkt_1 in_punkt
    ON in_mess.messpunkt_id = in_punkt.messpunkt_id
    AND in_mess.mandant_id = in_punkt.mandant_id) AND dat_bis='9999-12-31'

--where tp_objekt_id=10131925 
;