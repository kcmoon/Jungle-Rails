describe('Add to Cart Tests', () => {
  
  it("Should go to the home page", () => {
    cy.visit("/");
  });

  it("Confirm count change when add to cart is clicked", () => {
    cy.get('.btn').first().click({force: true});
    cy.get('.end-0').should('contain', '1')
  });

})