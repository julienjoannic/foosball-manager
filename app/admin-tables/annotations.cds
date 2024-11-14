using AdminService as service from '../../srv/AdminService';

annotate service.Tables with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Marque',
            Value : Brand,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Modèle',
            Value : Model,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Emplacement',
            Value : Location,
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Baby-foot',
        TypeNamePlural : 'Baby-foots',
        Title : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    },
);
annotate service.Tables with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Marque',
                Value : Brand,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Modèle',
                Value : Model,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Emplacement',
                Value : Location,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Couleur équipe #1',
                Value : Team1Color,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Couleur équipe #2',
                Value : Team2Color,
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
