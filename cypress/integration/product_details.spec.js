describe('Product Details Tests', () => {
  
  it("Should go to the home page", () => {
    cy.visit("/");
  });

  it("Should navigate to product details when a product is clicked", () => {
    cy.get("article").first().click();
    cy.url().should('include', 'products/2')
  });

})