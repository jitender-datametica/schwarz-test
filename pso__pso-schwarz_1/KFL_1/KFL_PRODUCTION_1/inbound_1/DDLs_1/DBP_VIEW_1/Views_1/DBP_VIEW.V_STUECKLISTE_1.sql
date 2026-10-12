CREATE OR REPLACE VIEW DBP_VIEW.V_STUECKLISTE_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,stueckliste_id                           COMMENT 'Eindeutige ID der Stückliste'
  ,dat_von                                  COMMENT 'Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'
  ,dat_bis                                  COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'
  ,art_id                                   COMMENT 'Artikelnummer der Stückliste'
  ,stueckliste_verwendung_id                COMMENT 'Eindeutiger Schlüssel für die Stücklistenverwendung'
)
COMMENT = 'TP2_AIS - Die Tabelle stueckliste_1 enthält die Stücklisten aus der SAP Tabelle MAST. Aktuell werden nur die Vollgutstücklisten in das DWH übertragen'
 AS 
    SELECT 
        mandant_id,
        stueckliste_id,
        dat_von,
        dat_bis,
        art_id,
        stueckliste_verwendung_id

FROM DBP_DATA.STUECKLISTE_1 ;