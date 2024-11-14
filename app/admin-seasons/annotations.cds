using AdminService as service from '../../srv/AdminService';

annotate service.Seasons with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Saison',
            Value : Number,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Début',
            Value : DateFrom,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Fin',
            Value : DateTo,
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Saison',
        TypeNamePlural : 'Saisons',
        Title : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    },
);
annotate service.Seasons with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Number,
                Label : 'Numéro',
            },
            {
                $Type : 'UI.DataField',
                Label : 'Date de début',
                Value : DateFrom,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Date de fin',
                Value : DateTo,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Données générales',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
annotate service.Seasons with {
    Number @Common.FieldControl : #ReadOnly
};

