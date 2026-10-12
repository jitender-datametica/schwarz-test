/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_REF_LOGISTICS_AGREEMENT_STATUS_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 14. September 2023 11:59:43
*/ --------------------------------------------------------------------------------



CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_logistics_agreement_status_1 (
logistics_agmt_status_cd STRING(20) NOT NULL OPTIONS(description='Status_1 of an agreement'),
logistics_agmt_status_descr STRING(100)
OPTIONS(description='Values are:Created(Erstellt) - The contract status_1 created indicates that a contract was created for the first time.Processed(Bearbeitet) - The contract status_1 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.Checked(Geprüft) - from the internal organizational unit_1 (contract management) - .Approved(Freigegeben) - The contract status_1 released indicates that a contract has been released by freight purchasing as an internal organizational unit_1 (foundation) - .Sent(Versendet) - The contract status_1 sent denotes the status_1 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_1) -  and logistics service provider (via Adobe Sign) - .signed(Unterschrieben) - The contract status_1 signed indicates that a contract has been signed by both contracting parties.'),
logistics_agmt_status_descr_de STRING(100)
OPTIONS(description='German description of statuses:Created(Erstellt) - The contract status_1 created indicates that a contract was created for the first time.Processed(Bearbeitet) - The contract status_1 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.Checked(Geprüft) - from the internal organizational unit_1 (contract management) - .Approved(Freigegeben) - The contract status_1 released indicates that a contract has been released by freight purchasing as an internal organizational unit_1 (foundation) - .Sent(Versendet) - The contract status_1 sent denotes the status_1 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_1) -  and logistics service provider (via Adobe Sign) - .signed(Unterschrieben) - The contract status_1 signed indicates that a contract has been signed by both contracting parties.'),
logistics_agmt_status_descr_en STRING(100)
OPTIONS(description='English description of statuses:	Created(Erstellt) - The contract status_1 created indicates that a contract was created for the first time.Processed(Bearbeitet) - The contract status_1 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.Checked(Geprüft) - from the internal organizational unit_1 (contract management) - .Approved(Freigegeben) - The contract status_1 released indicates that a contract has been released by freight purchasing as an internal organizational unit_1 (foundation) - .Sent(Versendet) - The contract status_1 sent denotes the status_1 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_1) -  and logistics service provider (via Adobe Sign) - .signed(Unterschrieben) - The contract status_1 signed indicates that a contract has been signed by both contracting parties.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (logistics_agmt_status_cd) NOT ENFORCED
)
OPTIONS(description='Agreement status_1 describes the current work status_1/status_1 of the contract. A distinction is made between different forms.');
