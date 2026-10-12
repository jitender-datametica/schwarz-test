/* --------------------------------------------------------------------------------
   DDL for table: t_building_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_building_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
building_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key of the building;'),
addr_sid BIGNUMERIC(38,0) OPTIONS(description='Associated (main) address_2 of the building'),
building_status_id BIGNUMERIC(38,0)
OPTIONS(description='building status_2 describing the lifecycle; from building initialized via approved to under contract and open; but also building rejected or finally closed; IMS_ESB object.info.current-status_2'),
building_status_dt DATE
OPTIONS(description='Date when the building status_2 has changed; IMS_ESB: object.status_2-development.status.date; IMS_ESB: object.status_development.status.date0'),
precontract_dt DATE
OPTIONS(description='Pre contract date; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = pre-contract: Vorvertragsdatum'),
contract_dt DATE
OPTIONS(description='Contract date; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = contract: Vertragsdatum'),
construction_start_dt DATE
OPTIONS(description='Construction start date; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = construction: Baubeginn'),
planned_opening_dt DATE
OPTIONS(description='Planned Opening date; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = neo: NEO - Datum - Voraussichtlich                        '),
opening_dt DATE
OPTIONS(description='Opening date; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = actual-neo: NEO - Datum'),
planned_closing_dt DATE
OPTIONS(description='Planned Closing date; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = plan-closing: Schlie?ung - Datum - Voraussichtlich'),
closing_dt DATE
OPTIONS(description='Closing date; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = closing: Schlie?ung - Datum'),
closing_reason_id BIGNUMERIC(38,0)
OPTIONS(description='Closing reason code; IMS_ESB object.status_development.status.status_date.closing_reason_id: Schlie?ungsgrund ( If there is more closing_reason_id, only get the  LAST  closing_reason_id )'),
closing_reason_txt STRING(1000)
OPTIONS(description='Free text comment on closing; IMS_ESB: object.status_development.status.status_date.remark'),
final_completion_dt DATE
OPTIONS(description='date of final completion; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = final-completion: Endabwicklung (Datum)'),
canceling_dt DATE
OPTIONS(description='date of canceling ; IMS_ESB: object.status_2-development.status.status_2-date.status_2-date-type = cancellation: Stornodatum (Keine Realisierungsabsicht)'),
canceling_reason_id BIGNUMERIC(38,0)
OPTIONS(description='Reason of cancelation; IMS_ESB: object.status_development.status.status_date.cancellation_reason_id.cancellation_reasonType: Stornogrund'),
temp_closing_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='indicating, whether the building will is temporary closed; IMS_ESB: object.status_2-development.status.temp-closing.: Vorubergehend geschlossen (Ja / Nein)'),
reconstruction_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='indicating, whether the building will be demolished and rebuilt; IMS_ESB: object.warehouse-data.demolition'),
purchase_type_id BIGNUMERIC(38,0)
OPTIONS(description='indicating, whether the building is rent (1), bought (2) or leased (3); IMS_ESB: object.info.object-type-id'),
ownership_type_id BIGNUMERIC(38,0)
OPTIONS(description='indicating, whether the building is fully owned (0), partially owned (1); IMS_ESB: object.warehouse-data.owner-type'),
leasing_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='indicating, whether the building is leased; IMS_ESB: object.warehouse-data.pt-leasing'),
own_acquisition_fg BIGNUMERIC(38,0) DEFAULT 0
OPTIONS(description='indicating, whether the building is own acquisioned; IMS_ESB: object.warehouse-data.own-akquisition'),
curr_sid BIGNUMERIC(38,0) OPTIONS(description='currency associated with the monetary amounts, e.g. lease_val'),
curr_cd STRING(3) COLLATE 'und:ci'
OPTIONS(description='currency associated with the monetary amounts, e.g. lease_val: IMS_ESB: object.info.currency'),
lease_per_year_val NUMERIC(18,5)
OPTIONS(description='yearly cost for renting/leasing; IMS_ESB: object.misc.sum-lease-offer'),
lease_income_per_year_val NUMERIC(18,5)
OPTIONS(description='yearly income due to leasing; IMS_ESB: object.misc.sum-lease-income'),
sales_area_in_meas NUMERIC(18,5)
OPTIONS(description='sales_2 area; IMS_ESB: object.area-data.areas.area (kind="bl" type="1")'),
unit_2 STRING(4) COLLATE 'und:ci' OPTIONS(description='unit_2 for sales_2 area; IMS_ESB: object.info.unit_2'),
parking_place_cnt BIGNUMERIC(38,0)
OPTIONS(description='total number of parking places: IMS_ESB: object.area-data.parking.total'),
owned_parking_place_cnt BIGNUMERIC(38,0)
OPTIONS(description='total number of owned parking places; IMS_ESB:object.area-data.parking.own'),
garage_parking_place_cnt BIGNUMERIC(38,0)
OPTIONS(description='total number of garage parking places; IMS_ESB:object.area-data.parking.garage'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (building_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Physical Buildings like Stores and Warehouses (historicized attributes)');