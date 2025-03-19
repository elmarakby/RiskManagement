using { RiskManagement as my } from '../db/schema.cds';

@path : '/service/RiskManagementService'
service RiskManagementService
{
    annotate Mitigations with @restrict :
    [
        { grant : [ '*' ], to : [ 'RiskManager' ] },
        { grant : [ '*' ], to : [ 'RiskViewer' ] },
        { grant : [ '*' ], to : [ 'authenticated-user' ] }
    ];

    annotate Risks with @restrict :
    [
        { grant : [ 'WRITE' ], to : [ 'authenticated-user' ] },
        { grant : [ 'WRITE' ], to : [ 'RiskManager' ] },
        { grant : [ 'WRITE' ], to : [ 'RiskViewer' ] }
    ];

    @odata.draft.enabled
    entity Risks as
        projection on my.Risks
        {
            *
        };

    @odata.draft.enabled
    entity Mitigations as
        projection on my.Mitigations;
}

annotate RiskManagementService with @requires :
[
    'authenticated-user',
    'RiskManager',
    'RiskViewer'
];
