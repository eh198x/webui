package postg

import (
	"errors"
	"fmt"
	"strings"
	"testing"
	"time"

	"webui/pkg/models"
)

func TestUserModelGet(t *testing.T) {
	// Skip the test if the `-short` flag is provided when running the test.
	// We'll talk more about this in a moment.
	if testing.Short() {
		t.Skip("postgres: skipping integration test")
	}
	// Set up a suite of table-driven tests and expected results.
	tests := []struct {
		name      string
		userID    int
		wantUser  *models.User
		wantError error
	}{
		{
			name:   "Valid ID",
			userID: 1,
			wantUser: &models.User{
				ID:      1,
				Name:    "Alice Jones",
				Email:   "alice@example.com",
				Created: time.Date(2018, 12, 23, 17, 25, 22, 0, time.UTC),
				Active:  true,
			},
			wantError: nil,
		},
		{
			name:      "Zero ID",
			userID:    0,
			wantUser:  nil,
			wantError: models.ErrNoRecord,
		},
		{
			name:      "Non-existent ID",
			userID:    2,
			wantUser:  nil,
			wantError: models.ErrNoRecord,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Initialize a connection pool to our test database, and defer a
			// call to the teardown function, so it is always run immediately
			// before this sub-test returns.
			db, teardown := newTestDB(t)
			defer teardown()
			// Create a new instance of the UserModel.
			m := UserModel{db}
			// Call the UserModel.Get() method and check that the return value
			// and error match the expected values for the sub-test.
			user, err := m.Get(tt.userID)
			if !errors.Is(err, tt.wantError) {
				//if err != tt.wantError {
				t.Errorf("Error want \n[%v] got \n[%s]", tt.wantError, err)
			}

			stringuser := fmt.Sprintf("%v", user)
			stringwantuser := fmt.Sprintf("%v", tt.wantUser)
			if strings.Compare(stringuser, stringwantuser) != 0 {
				//if !reflect.DeepEqual(user, tt.wantUser) {
				t.Errorf("User want \n[%v] got \n[%v]", tt.wantUser, user)
			}
		})
	}
}
