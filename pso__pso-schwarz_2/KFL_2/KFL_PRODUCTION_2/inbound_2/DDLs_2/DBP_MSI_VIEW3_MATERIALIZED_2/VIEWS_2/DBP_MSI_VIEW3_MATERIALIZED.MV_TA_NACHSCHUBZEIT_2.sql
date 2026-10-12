create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TA_NACHSCHUBZEIT_2(
	MANDANT_ID,
	LAGERNUMMER_ID,
	TRANSPORT_BELEG_ID,
	TRANSPORT_BELEG_POS_ID,
	GLOBAL_VON_LAGERTYP_ID,
	NACH_LAGERTYP_ID,
	VON_LAGERTYP_ID,
	DAT_ERSTELLUNG,
	NACHSCHUBZEIT_SEKUNDEN,
	COUNT_BELEG,
	STATUS_QUITTIERUNG
) as
   SELECT
   mandant_id,
   lagernummer_id,
   transport_beleg_id,
   transport_beleg_pos_id,
   global_von_lagertyp_id,
   nach_lagertyp_id,
   von_lagertyp_id,
   dat_erstellung,
   CAST(
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, erstellung_dt, quittierung_dt)):DAY * 86400 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, erstellung_dt, quittierung_dt)):HOUR * 3600 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, erstellung_dt, quittierung_dt)):MINUTE * 60 ) +
   (SNOWCONVERT.PUBLIC.time_part_to_variant(TIMESTAMPDIFF(SECOND, erstellung_dt, quittierung_dt)):SECOND   ) AS NUMBER(38,5))
   AS nachschubzeit_sekunden,
   count_beleg,
   status_quittierung
   FROM
   (
   SELECT
   t1.mandant_id,
   t1.wup_id,
   t1.nb_id,
   t1.lagernummer_id,
   t2.transport_beleg_id,
   t2.transport_beleg_pos_id,
   CASE WHEN SUBSTR( t2.von_lagertyp_id, 1, 2) = 'R0'       THEN 'Regal Erdgeschoss'
   WHEN SUBSTR( t2.von_lagertyp_id, 1, 2) = 'R1'       THEN 'Regal Obergeschoss'
   WHEN t2.von_lagertyp_id = 'H01'          THEN 'Hochregal'
   WHEN t2.von_lagertyp_id IN ('RH1', 'RT1') THEN 'AKL-Hochregal'
   ELSE 'Sonstige' END global_von_lagertyp_id,
   t2.nach_lagertyp_id,
   t2.von_lagertyp_id,
   t1.dat_erstellung,
   timestamp_from_parts(t1.dat_erstellung,t1.zeit_erstellung) AS erstellung_dt,
   timestamp_from_parts(t2.dat_quittierung,t2.zeit_quittierung) AS quittierung_dt,
   CAST(t1.mandant_id AS CHAR(1))||t1.lagernummer_id||CAST(t1.transport_beleg_id AS CHAR(18)) AS count_beleg,
   /** alter Zweig **
   CASE WHEN t2.quittierung_fg = 1 AND t2.menge_soll_von = t2.menge_ist_nach
   THEN 'voll quittiert'
   WHEN t2.quittierung_fg = 1 AND t2.menge_soll_von > t2.menge_ist_nach
   THEN 'teil quittiert'
   WHEN t2.quittierung_fg = 1 AND t2.transport_vorgang_id IN ('st', 'sl')
   THEN 'storniert'
   WHEN t2.quittierung_fg = 0
   THEN 'offen'
   ELSE 'sonstiges'
   END (VARCHAR(14))  AS status_quittierung
   **/
   -- Änderung lt. Mail vom 18.07.2013
   CASE  WHEN quittierung_fg = 1 AND (menge_soll_von = menge_ist_nach OR (menge_soll_von=0 AND menge_ist_nach>0)) AND COALESCE(transport_vorgang_id,'') NOT IN ('st', 'sl')
   THEN 'voll quittiert'
   WHEN quittierung_fg = 1 AND menge_soll_von > menge_ist_nach AND COALESCE(transport_vorgang_id,'') NOT IN ('st', 'sl')
   THEN 'teil quittiert'
   WHEN quittierung_fg = 1 AND transport_vorgang_id IN ('st', 'sl')
   THEN 'storniert'
   WHEN quittierung_fg = 0
   THEN 'offen'
   ELSE 'sonstiges'
   END::VARCHAR(14)  AS status_quittierung
   FROM dbp_view.v_transportauftrag_2 t1_2
   INNER JOIN dbp_view.v_transportauftrag_det_2 t2
   ON  t1.mandant_id = t2.mandant_id
   AND t1.lagernummer_id = t2.lagernummer_id
   AND t1.transport_beleg_id = t2.transport_beleg_id
   WHERE extract(year from t1.dat_erstellung) >= year(current_timestamp) - 2
   ) tmp;