CREATE TABLE CORE_OCTOPUS.T_DIM_LOGISTICS_AGREEMENT_STATUS_1 (
   logistics_agmt_status_cd            VARCHAR(20)     NOT NULL COMMENT 'Status_1 of an agreement',
   logistics_agmt_status_descr         VARCHAR(100)    COMMENT 'Values are:	
            Created(Erstellt) - The contract status_1 created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status_1 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status_1 checked indicates that a contract has been checked by a second employee_1 (not the person who created the contract) -  from the internal organizational unit_1 (contract management) - .
            Approved(Freigegeben) - The contract status_1 released indicates that a contract has been released by freight purchasing as an internal organizational unit_1 (foundation) - .
            Sent(Versendet) - The contract status_1 sent denotes the status_1 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_1) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status_1 signed indicates that a contract has been signed by both contracting parties.
            ',
   logistics_agmt_status_descr_de      VARCHAR(100)    COMMENT 'German description of statuses:	
            Created(Erstellt) - The contract status_1 created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status_1 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status_1 checked indicates that a contract has been checked by a second employee_1 (not the person who created the contract) -  from the internal organizational unit_1 (contract management) - .
            Approved(Freigegeben) - The contract status_1 released indicates that a contract has been released by freight purchasing as an internal organizational unit_1 (foundation) - .
            Sent(Versendet) - The contract status_1 sent denotes the status_1 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_1) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status_1 signed indicates that a contract has been signed by both contracting parties.
            ',
   logistics_agmt_status_descr_en      VARCHAR(100)    COMMENT 'English description of statuses:		
            Created(Erstellt) - The contract status_1 created indicates that a contract was created for the first time.
            Processed(Bearbeitet) - The contract status_1 processed means that a change has been made to a contract and the processing has been completed. The contract is thus blocked from further changes.
            Checked(Geprüft) - The contract status_1 checked indicates that a contract has been checked by a second employee_1 (not the person who created the contract) -  from the internal organizational unit_1 (contract management) - .
            Approved(Freigegeben) - The contract status_1 released indicates that a contract has been released by freight purchasing as an internal organizational unit_1 (foundation) - .
            Sent(Versendet) - The contract status_1 sent denotes the status_1 that a contract has been sent to the logistics service provider (if by post) -  or to freight purchasing (internal organizational unit_1) -  and logistics service provider (via Adobe Sign) - .
            signed(Unterschrieben) - The contract status_1 signed indicates that a contract has been signed by both contracting parties.
            ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_DIM_LOGISTICS_AGREEMENT_STATUS PRIMARY KEY (logistics_agmt_status_cd) NOT ENFORCED 
)  COMMENT = 'Agreement status_1 describes the current work status_1/status_1 of the contract. A distinction is made between different forms.';
