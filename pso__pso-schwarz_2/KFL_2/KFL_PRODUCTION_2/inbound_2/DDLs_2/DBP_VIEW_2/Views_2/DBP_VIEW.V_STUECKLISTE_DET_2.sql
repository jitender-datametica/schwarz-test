CREATE OR REPLACE VIEW DBP_VIEW.V_STUECKLISTE_DET_2 (
   art_id                                   COMMENT 'Artikelnummer der Stücklistenkomponente'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,stueckliste_id                           COMMENT 'Eindeutige ID der Stückliste'
  ,stueckliste_pos_id                       COMMENT 'Nummer der Position der Stücklistenkomponente'
  ,dat_von                                  COMMENT 'Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat'
  ,dat_bis                                  COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat'
  ,stueckliste_typ_id                       COMMENT 'Eindeutiger Schlüssel für die Stücklistentypen.'
  ,komponentenmenge                         COMMENT 'Menge der Stücklistenkomponente'
  ,komponentenmenge_einh_id                 COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert.Aus meinh'
)
COMMENT = 'TP2_AIS - Die Tabelle stueckliste_det_2 enthält die Stücklistenpositionen aus der SAP Tabelle STPO. Eine_2 Stückliste besteht aus einer oder mehreren Komponenten.'
 AS 
    SELECT 
        art_id,
        mandant_id,
        stueckliste_id,
        stueckliste_pos_id,
        dat_von,
        dat_bis,
        stueckliste_typ_id,
        komponentenmenge,
        komponentenmenge_einh_id

FROM DBP_DATA.STUECKLISTE_DET_2 ;