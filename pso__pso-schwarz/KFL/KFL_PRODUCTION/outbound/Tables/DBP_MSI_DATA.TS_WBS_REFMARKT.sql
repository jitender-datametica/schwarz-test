--==============================================================
-- Table: ts_wbs_refmarkt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_refmarkt
   generated from Powerdesigner on Dienstag, 29. April 2025 09:21:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wbs_refmarkt (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'),
wup_id_ref BIGNUMERIC(38,0) OPTIONS(description='Referenzfiliale WUP_ID (exisitierender Markt).'),
nb_id_ref BIGNUMERIC(38,0) OPTIONS(description='Referenzfiliale NB_ID Nebenbetriebskennziffer (existierender Markt).'),
ref_faktor_fallback NUMERIC(9,2)
OPTIONS(description='Referenzfaktor (wird mit der Werbemenge der Referenzfiliale multipliziert).'),
mandant_id_vz_fallback BIGNUMERIC(38,0) OPTIONS(description='Mandant VZ Fallback.'),
wup_id_vz_fallback BIGNUMERIC(38,0) OPTIONS(description='Verteilzentrum VZ Fallback.'),
nb_id_vz_fallback BIGNUMERIC(38,0) OPTIONS(description='Nebenbetrieb VZ Fallback,'),
fixamount_share_alg_500 NUMERIC(8,3) OPTIONS(description='Share/Anteil fuer die Auslieferungsgruppe 500.'),
fixamount_share_alg_120 NUMERIC(8,3) OPTIONS(description='Share/Anteil fuer die Auslieferungsgruppe 120.'),
estimation_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Estimation.'),
adjustment_id BIGNUMERIC(38,0)
OPTIONS(description='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.            2 = Platzhalter (Stand 28.03.2025)            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine manuelle Bestellanlage durch das Land notwendig. '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
)
OPTIONS(description='Settings for WBS calculation core on Reference Store level / content maintained by transaction services document.');