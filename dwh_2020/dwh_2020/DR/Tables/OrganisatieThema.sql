CREATE TABLE [DR].[OrganisatieThema] (
    [OrganisatieThemaID]      NVARCHAR (15)  NOT NULL,
    [HoofdOrganisatieThemaID] NVARCHAR (15)  NULL,
    [ExtraInfo]               NVARCHAR (255) NULL,
    [Description]             NVARCHAR (50)  NOT NULL,
    [DependencySet]           NVARCHAR (200) NULL,
    [SortOrder]               INT            NULL,
    [Comment]                 NVARCHAR (800) NULL,
    [SoftDeleted]             BIT            DEFAULT ((0)) NOT NULL,
    [RowVersion]              ROWVERSION     NOT NULL,
    CONSTRAINT [PK_OrganisatieThema] PRIMARY KEY CLUSTERED ([OrganisatieThemaID] ASC),
    CONSTRAINT [FK_OrganisatieThema_HoofdrganisatieThema] FOREIGN KEY ([HoofdOrganisatieThemaID]) REFERENCES [DR].[OrganisatieThema] ([OrganisatieThemaID])
);

