/* --------------------------------------------------------------------------------
   DDL for table: t_item_info_per_location_hist_1
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_info_per_location_hist_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item_1'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store / WH'),
item_status_id BIGNUMERIC(38,0),
order_area_sid BIGNUMERIC(38,0) OPTIONS(description='surrogate key; uniquely identifies a WH Order Area'),
pur_grp_sid BIGNUMERIC(38,0) OPTIONS(description='responsible purchase group for the item_1'),
item_status_cd STRING(20) OPTIONS(description='location_1 specific item_1 status_1; SAP-Retail: marc.mmsta;'),
item_status_active_from_dt DATE OPTIONS(description='date when the item_1 status_1 became active; SAP-Retail: marc.mmstd;'),
case_size_dec_qty NUMERIC(9,5) OPTIONS(description='how many pieces / how much weight are/is grouped to one case'),
euro_pallet_factor_qty NUMERIC(9,5) OPTIONS(description='how many cases do fit onto a Euro-Pallet'),
dd_pallet_factor_qty NUMERIC(9,5) OPTIONS(description='how many cases do fit onto a Dusseldorf-Pallet'),
layer_factor_qty NUMERIC(9,5) OPTIONS(description='how many cases do fit onto one layer of a Euro-Pallet'),
pallet_factor NUMERIC(18,5)
OPTIONS(description='Palettenfaktor; berechnet bei der Extraktion durch SAP-BW: t_bw_0art_plant_attr/t_bw_z_ds_mxxd2016.zzev_pal_fak;'),
pallet_factor_dus NUMERIC(18,5)
OPTIONS(description='Duesseldorfer Palettenfaktor; berechnet bei der Extraktion durch SAP-BW: t_bw_0art_plant_attr/t_bw_z_ds_mxxd2016.zzv_dus_fakt;'),
pallet_factor_gma NUMERIC(18,5) OPTIONS(description='GMA Palettenfaktor; SAP-BW: t_bw_z_ds_mxxd2016.zkgmafakt;'),
case_factor NUMERIC(18,5)
OPTIONS(description='Kollifaktor; berechnet bei der Extraktion durch SAP-BW: t_bw_0art_plant_attr/t_bw_z_ds_mxxd2016.zzev_kol_fakt;'),
shelflife_cust_cd STRING(20)
OPTIONS(description='Restlaufzeit Kunde - Einheit: T=Tag_1, W=Woche_1, M=Monat_1, J=Jahr; SAP-Retail: marc.zz_rlzkm; SAP-BW: t_bw_0art_plant_attr.zz_rlzkm;'),
shelflife_cust_val NUMERIC(18,5)
OPTIONS(description='Restlaufzeit Kunde - Wert; SAP-Retail: marc.zz_rlzk; SAP-BW: t_bw_0art_plant_attr.zz_rlzk;'),
shelflife_loc_cd STRING(20)
OPTIONS(description='Restlaufzeit Filiale - Einheit: T=Tag_1, W=Woche_1, M=Monat_1, J=Jahr; SAP-Retail: marc.zz_rlzfm; SAP-BW: t_bw_0art_plant_attr.zz_rlzfm;'),
shelflife_loc_val NUMERIC(18,5)
OPTIONS(description='Restlaufzeit Filiale - Wert; SAP-Retail: marc.zz_rlzf; SAP-BW: t_bw_0art_plant_attr.zz_rlzf;'),
shelflife_vz_cd STRING(20)
OPTIONS(description='Restlaufzeit Betrieb - Einheit: T=Tag_1, W=Woche_1, M=Monat_1, J=Jahr; SAP-Retail: marc.zz_rlzbm; SAP-BW: t_bw_0art_plant_attr.zz_rlzbm;'),
shelflife_vz_val NUMERIC(18,5)
OPTIONS(description='Restlaufzeit Betrieb - Wert; SAP-Retail: marc.zz_rlzb; SAP-BW: t_bw_0art_plant_attr.zz_rlzb;'),
replenishment_type_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='Dispositionsmerkmal; SAP-Retail: marc.dismm;'),
replenishment_planner_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='Disponent; SAP-Retail: marc.dispo;'),
procurement_type_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Beschaffungsart; E=Eigenfertigung; F=Fremdbeschaffung; X=beide Beschaffungsarten; SAP-Retail: marc.beskz; SAP-BW: t_bw_0art_plant_attr.beskz;'),
source_of_supply_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Bezugsquelle, 1=Normal, 2=Umlagerung_1, ... siehe SAP-Retail-Ref.-Tab TMBW1; SAP-Retail: marc.bwscl; SAP-BW: t_bw_0art_plant_attr.bwscl;'),
rounding_profile_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='Rundungsprofil, ...siehe SAP-Retail-Ref.-Tab RDPR; SAP-Retail marc.rdprf; SAP-BW: t_bw_0art_plant_attr.rdprf;'),
stock_max_qty NUMERIC(18,5) OPTIONS(description='Hoechstbestand; SAP-Retail: -; SAP-BW: t_bw_0art_plant_attr.zzmabst;'),
order_min_qty NUMERIC(18,5)
OPTIONS(description='Mindestlosgroesse; SAP-Retail: ; SAP-BW: t_bw_0art_plant_attr.zzbstmi;'),
target_range_min_qty NUMERIC(18,5)
OPTIONS(description='Minimale Sollreichweite; SAP-Retail: marc.min_troc; SAP-BW: t_bw_0art_plant_attr.min_troc;'),
target_range_max_qty NUMERIC(18,5)
OPTIONS(description='Maximale Sollreichweite; SAP-Retail: marc.max_troc; SAP-BW: t_bw_0art_plant_attr.max_troc;'),
item_marked_for_deletion_fg BIGNUMERIC(38,0)
OPTIONS(description='Artikel_1 auf Betriebsebene zum Loeschen vormerken; SAP-Retail: marc.lvorm; SAP-BW: t_bw_0art_plant_attr.lvorm;'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1-Lokation-Bez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (item_sid, loc_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Information regarding Items in relation to a certain Store or Warehouse;             SAP-Retail: marc_1;             SAP-BW: t_bw_0art_plant_attr;             WAWI: t_itm_item_wh             ');