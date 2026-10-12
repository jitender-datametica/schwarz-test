CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_per_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'), wg_id
OPTIONS(description='ID der Warengruppe'), arthiertyp_id
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
dat_von OPTIONS(description='Datum, ab welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM_1-DD\''), lead_mwst_id
OPTIONS(description='führende Mehrwertsteuersatz - ID (<> Mehrwertsteuersatz!)'), abt_id
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte ID\'s, positive Werte: aus Stammdatensystem übernommen'),
dat_bis OPTIONS(description='Datum, bis zu welchem dieser Mehrwertsteuersatz gilt. Format\'YYYY-MM_1-DD\''), owg_id
OPTIONS(description='ID der Oberwarengruppe'), platzierungswg_id
OPTIONS(description='Platzierungswarengruppe - im DWH generierter numerischer Schlüssel'), werbeteam_cd
OPTIONS(description='Code des Werbeteams'))
OPTIONS(DESCRIPTION = `TP1 - TP2 - WARENGRUPPE - STUFE IN DER ARTIKELHIERARCHIE(ARTHIERTYP_ID NICHT FÜR PK BENÖTIGT)`)
AS SELECT mandant_id,
 wg_id,
 arthiertyp_id,
 dat_von,
 lead_mwst_id,
 abt_id,
 dat_bis,
 owg_id,
 platzierungswg_id,
 werbeteam_cd
FROM kfl_production_dbp_data.wg_per_1;