--==============================================================
-- Table: ts_wbs_refmarkt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_refmarkt_2
   generated from Powerdesigner on Dienstag, 29. April 2025 09:21:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_REFMARKT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   wup_id_ref                          INTEGER     COMMENT 'Referenzfiliale WUP_ID (exisitierender Markt).',
   nb_id_ref                           INTEGER     COMMENT 'Referenzfiliale NB_ID Nebenbetriebskennziffer (existierender Markt).',
   ref_faktor_fallback                 NUMBER(29,2)      COMMENT 'Referenzfaktor (wird mit der Werbemenge der Referenzfiliale multipliziert).',
   mandant_id_vz_fallback              INTEGER     COMMENT 'Mandant_2 VZ Fallback.',
   wup_id_vz_fallback                  INTEGER     COMMENT 'Verteilzentrum VZ Fallback.',
   nb_id_vz_fallback                   INTEGER     COMMENT 'Nebenbetrieb VZ Fallback,',
   fixamount_share_alg_500             NUMBER(29,3)      COMMENT 'Share/Anteil fuer die Auslieferungsgruppe 500.',
   fixamount_share_alg_120             NUMBER(29,3)      COMMENT 'Share/Anteil fuer die Auslieferungsgruppe 120.',
   estimation_fg                       INTEGER     COMMENT 'Flag: Estimation.',
   adjustment_id                       INTEGER     COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.
            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R
            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.
            2 = Platzhalter (Stand 28.03.2025)
            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_2 manuelle Bestellanlage durch das Land_2 notwendig. ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_REFMARKT PRIMARY KEY (mandant_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'Settings for WBS calculation core on Reference Store level / content maintained by transaction services document.';
