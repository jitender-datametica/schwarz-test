CREATE OR REPLACE VIEW DBP_VIEW.V_ROHSTOFF_1 (
   rohstoff_nr                              COMMENT 'Mintecs Interne ID des Rohstoffs.'
  ,rohstoff_basis_einh_name                 COMMENT 'Die Basiseinheit des Rohstoffs (native).'
  ,rohstoff_bez                             COMMENT 'Bezeichnung des Rohstoffs.'
  ,rohstoff_kfl_bez                         COMMENT 'Kaufland interne Bezeichnung des Rohstoffs.'
  ,rohstoff_beschreibung_txt                COMMENT 'Beschreibung des Rohstoffs.'
  ,rohstoff_qualitaet_txt                   COMMENT 'Beschreibung der Qualität des Rohstoffs.'
  ,rohstoff_herkunftsort_name               COMMENT 'Herkunfsort des Rohstoffs - Dieser kann Land_1, Region_1 oder Länderguppe sein.'
  ,rohstoff_lieferort_name                  COMMENT 'Land_1, Region_1 oder Ländergruppe, die den Rohstof fliefert.'
  ,rohstoff_quell_bez                       COMMENT 'Enthält Informationen zur Quelle des Rohstoffes.'
)
COMMENT = 'Diese Tabelle enthält Informationen über die Rohstoffe verwendet bei Kaufland.'
 AS 
    SELECT 
        rohstoff_nr,
        rohstoff_basis_einh_name,
        rohstoff_bez,
        rohstoff_kfl_bez,
        rohstoff_beschreibung_txt,
        rohstoff_qualitaet_txt,
        rohstoff_herkunftsort_name,
        rohstoff_lieferort_name,
        rohstoff_quell_bez

FROM DBP_DATA.ROHSTOFF_1 ;