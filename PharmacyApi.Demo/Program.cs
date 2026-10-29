using Azure.Identity;

var builder = WebApplication.CreateBuilder(args);

var keyVaultUri = builder.Configuration["KeyVaultUri"];
if (!string.IsNullOrEmpty(keyVaultUri))
{
    builder.Configuration.AddAzureKeyVault(
        new Uri(keyVaultUri),
        new DefaultAzureCredential());
}

var app = builder.Build();

app.MapGet("/health", (IConfiguration config) =>
{
    var hasSecret = !string.IsNullOrEmpty(config["SqlConnectionString"]);
    return Results.Ok(new { status = "healthy", secretLoaded = hasSecret });
});

app.MapGet("/prescriptions/{id}", (int id) =>
    Results.Ok(new { Id = id, DrugName = "Amoxicillin", Dosage = "500mg" }));

app.Run();