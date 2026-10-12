CREATE OR REPLACE VIEW DBP_VIEW.V_ROHSTOFF_PREISENTWICKLUNG_1 (
   rohstoff_nr                              COMMENT 'Mintecs Interne ID des Rohstoffs.'
  ,dat_rohstoff_preis                       COMMENT 'Datum des Preises des Rohstoffs.'
  ,rohstoff_einh_name                       COMMENT 'Einheit des Rohstoffs. Für einen Rohstoff_1 gibt es verschiedene Einheiten in dem sie dargstellt werden können z.B. LITER - KG - TONNE etc. Nicht zur verwechseln mit der basis_einheit_name.'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR'
  ,frequenz_cd                              COMMENT 'Sie gibt die native Preisfrequenz des Rohstoffs an, d.h. welcher Preis hat sie zu diesem Tag. Hier steht "Weekly", "Daily", ''Yearly'' etc.)'
  ,kjwo                                     COMMENT 'Kalenderjahreswoche (Format JJJJWW) des Preis des Rohstoffs. Derzeit ein Preis pro Woche. ( Stand 17.03.2025).'
  ,preis_rohstoff_max                       COMMENT 'Maximal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'
  ,preis_rohstoff_min                       COMMENT 'Minnimal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'
  ,preis_rohstoff_avg                       COMMENT 'Durchschnittspreis zwischen den maximalen und minimalen Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'
  ,preis_gefuellt_fg                        COMMENT 'Falls es für einen DAT keinen Preis gibt, wird es für den DAT in der Extraktion ein GapFillValue hinzugefügt mit dem Wert -9999. Bei einen Wert von -9999 wird preis_gefuellt_fg auf 1 gesetzt. Bei nachträglicher Preislieferung wird der Wert dann auf 0 gesetzt.'
)
COMMENT = 'Preisentwicklung des Rohstoffspreises.'
 AS 
    SELECT 
        rohstoff_nr,
        dat_rohstoff_preis,
        rohstoff_einh_name,
        wrg_id,
        frequenz_cd,
        kjwo,
        preis_rohstoff_max,
        preis_rohstoff_min,
        preis_rohstoff_avg,
        preis_gefuellt_fg

FROM DBP_DATA.ROHSTOFF_PREISENTWICKLUNG_1 ;