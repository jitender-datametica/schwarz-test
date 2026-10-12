CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_VTR_GRP(
	VTR_GRP_ID,
	VTR_GRP_BEZ,
	VTR_GRP_BEZ_CZ,
	VTR_GRP_BEZ_SK,
	VTR_GRP_BEZ_HR,
	VTR_GRP_BEZ_PL,
	VTR_GRP_BEZ_RO,
	VTR_GRP_BEZ_BG
) AS 
 
/*	VTR LOOKUP : METRIKGRUPPEN (KENNZAHLENBLÖCKE)
	2023-07-31 ssch0611 : Initial. AP0176993
	2023-08-21 ssch0611 : Unicode: Kunden­versprechen enthält weichen Bindestrich (ALT+0173)
	2023-09-06 ssch0611 : Update_090 Neue View Struktur/Syntax
	2024-01-10 ssch0611 : Release Version
*/ 
SELECT 
  $1::INTEGER AS VTR_GRP_ID
, $2::STRING  AS VTR_GRP_BEZ
, $3::STRING  AS VTR_GRP_BEZ_CZ
, $4::STRING  AS VTR_GRP_BEZ_SK
, $5::STRING  AS VTR_GRP_BEZ_HR
, $6::STRING  AS VTR_GRP_BEZ_PL
, $7::STRING  AS VTR_GRP_BEZ_RO
, $8::STRING  AS VTR_GRP_BEZ_BG
FROM ( 
SELECT 0, 'Gesamt', 'Celkem', 'Celkom', 'Ukupno', 'Razem', 'Total', 'Общо' 
UNION ALL SELECT 1::INTEGER, 'Umsatz & Leistung', 'Obrat & Výkon', 'Obrat a Výkon', 'Promet & produktivnost', 'Obrót i produktywność', 'Vânzăre & Eficiență', 'Оборот и Продуктивност' 
UNION ALL SELECT 3::INTEGER, 'Abschriften & Inventur', 'Odpisy & Inventura', 'Odpisy a inventúra', 'Otpisi & inventura', 'Odpisy i inwentaryzacja', 'Pierderi & Inventar', 'Загуби & Инвент.' 
UNION ALL SELECT 5::INTEGER, 'Kunden­versprechen', 'Zákaznické záruky', 'Zákaznícke záruky / servis', 'Garancije kupcima', 'Obietnice dla klientów', 'Garanții pentru clienți', 'Клиентски обещеания' 
UNION ALL SELECT 7::INTEGER, 'FWWS', 'FWWS', 'FWWS', 'FWWS', 'FWWS', 'FWWS', 'FWWS' 
) vtr_grp;