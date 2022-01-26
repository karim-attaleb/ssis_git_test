CREATE TABLE [IR].[IndieningPartijHoedanigheidType] (
    [IndieningPartijHoedanigheidTypeID]       NVARCHAR (15)  NOT NULL,
    [IndieningPartijHoedanigheidTypeParentID] NVARCHAR (15)  NULL,
    [Description]                             NVARCHAR (100) NOT NULL,
    [DependencySet]                           NVARCHAR (200) NULL,
    [SortOrder]                               INT            NULL,
    [Comment]                                 NVARCHAR (800) NULL,
    [SoftDeleted]                             BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]                              ROWVERSION     NOT NULL,
    CONSTRAINT [PK_IndieningPartijHoedanigheidType] PRIMARY KEY CLUSTERED ([IndieningPartijHoedanigheidTypeID] ASC),
    CONSTRAINT [FK_IndieningPartijHoedanigheidType_IndieningPartijHoedanigheidType] FOREIGN KEY ([IndieningPartijHoedanigheidTypeParentID]) REFERENCES [IR].[IndieningPartijHoedanigheidType] ([IndieningPartijHoedanigheidTypeID])
);

