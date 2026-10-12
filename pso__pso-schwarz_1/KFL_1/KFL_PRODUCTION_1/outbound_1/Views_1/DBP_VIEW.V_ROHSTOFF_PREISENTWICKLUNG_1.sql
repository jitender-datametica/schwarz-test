CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rohstoff_preisentwicklung_1 (rohstoff_nr
OPTIONS(description='Mintecs Interne ID des Rohstoffs.'), dat_rohstoff_preis
OPTIONS(description='Datum des Preises des Rohstoffs.'), rohstoff_einh_name
OPTIONS(description='Einheit des Rohstoffs. Für einen Rohstoff_1 gibt es verschiedene Einheiten in dem sie dargstellt werden können z.B. LITER - KG - TONNE etc. Nicht zur verwechseln mit der basis_einheit_name.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), frequenz_cd
OPTIONS(description='Sie gibt die native Preisfrequenz des Rohstoffs an, d.h. welcher Preis hat sie zu diesem Tag. Hier steht "Weekly", "Daily", "Yearly" etc.)'),
kjwo
OPTIONS(description='Kalenderjahreswoche (Format JJJJWW) des Preis des Rohstoffs. Derzeit ein Preis pro Woche. ( Stand 17.03.2025).'),
preis_rohstoff_max
OPTIONS(description='Maximal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'),
preis_rohstoff_min
OPTIONS(description='Minnimal Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'),
preis_rohstoff_avg
OPTIONS(description='Durchschnittspreis zwischen den maximalen und minimalen Preis des Rohstoffs. Preise mit einem Wert von "null" (Fehlerwert) haben in der Quelle keinen Wert. Im Beladungsprozess wird der festgelegt GapFillValue von -9999 auf null gesetzt. Kommt dann zum späteren Zeitpunkt wieder ein Wert, dann die überschriebenen Fehlwerte linear interpolieren.'),
preis_gefuellt_fg
OPTIONS(description='Falls es für einen DAT keinen Preis gibt, wird es für den DAT in der Extraktion ein GapFillValue hinzugefügt mit dem Wert -9999. Bei einen Wert von -9999 wird preis_gefuellt_fg auf 1 gesetzt. Bei nachträglicher Preislieferung wird der Wert dann auf 0 gesetzt.'))
OPTIONS(DESCRIPTION = `Preisentwicklung des Rohstoffspreises.`) AS SELECT rohstoff_nr,
 dat_rohstoff_preis,
 rohstoff_einh_name,
 wrg_id,
 frequenz_cd,
 kjwo,
 preis_rohstoff_max,
 preis_rohstoff_min,
 preis_rohstoff_avg,
 preis_gefuellt_fg
FROM kfl_production_dbp_data.rohstoff_preisentwicklung_1;