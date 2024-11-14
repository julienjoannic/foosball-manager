using AdminService as service from '../../srv/AdminService';

annotate service.Players with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Nom',
            Value : Name,
        },
        {
            $Type : 'UI.DataField',
            Value : Username,
            Label : 'Nom d''utilisateur',
        },
    ],
    UI.HeaderInfo : {
        TypeName : 'Joueur',
        TypeNamePlural : 'Joueurs',
        Title : {
            $Type : 'UI.DataField',
            Value : Name,
        },
    },
);
annotate service.Players with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Nom',
                Value : Name,
            },
            {
                $Type : 'UI.DataField',
                Value : Username,
                Label : 'Nom d''utilisateur',
            },
            {
                $Type : 'UI.DataField',
                Value : DefaultTable_ID,
                Label : 'Baby-foot habituel',
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
annotate service.Players with {
    DefaultTable @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Tables',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : DefaultTable_ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : {
            $value : DefaultTable.Description,
            ![@UI.TextArrangement] : #TextOnly,
        },
        Common.SemanticObject : 'AdminTables'
)};

annotate service.Tables with {
    ID @Common.Text : {
        $value : Description,
        ![@UI.TextArrangement] : #TextOnly,
    }
};

