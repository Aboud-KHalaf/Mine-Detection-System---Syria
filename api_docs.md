Base URL: `http://<your-domain>/api/`

---

## 0. API Authentication
- **Method:** `POST`
- **URL:** `/api/login/`
- **Content-Type:** `application/json`

### Request Body
```json
{
  "username": "admin",
  "password": "your_password"
}
```

### Success Response
```json
{
  "token": "0123456789abcdef0123456789abcdef01234567"
}
```

### Note
After obtaining the token, use the following header for protected requests:  
`Authorization: Token <your_token>`

---

## 1. Get All Zones
- **Method:** `GET`
- **URL:** `/api/zones/`

### Description
Returns all zones in GeoJSON format with the necessary properties for map rendering.

### Sample Response
```json
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "id": 1,
      "properties": {
        "id": 1,
        "name": "Zone 1",
        "status": "unsafe",
        "status_display": "Unsafe Zone",
        "description": "...",
        "created_at": "2026-04-14T12:00:00",
        "created_by": "admin",
        "mines_count": 3,
        "estimated_area": 1.5,
        "shape_type": "polygon",
        "shape_radius": null
      },
      "geometry": { "..." }
    }
  ]
}
```

### JavaScript Usage Example
```javascript
fetch('/api/zones/')
  .then(res => res.json())
  .then(data => console.log(data));
```

---

## 2. Create a New Zone
- **Method:** `POST`
- **URL:** `/api/zones/`
- **Content-Type:** `application/json`

### Note
This operation is protected and requires an Admin user token.

### Request Body
```json
{
  "name": "New Zone",
  "description": "Zone description",
  "status": "unsafe",
  "coordinates": {
    "type": "Polygon",
    "coordinates": [
      [[38.0, 34.0], [39.0, 34.0], [39.0, 35.0], [38.0, 35.0], [38.0, 34.0]]
    ]
  },
  "shape_type": "polygon",
  "shape_radius": null,
  "estimated_area": 2.3,
  "notes": "Additional notes"
}
```

### Success Response
```json
{
  "success": true,
  "zone_id": 5,
  "message": "Zone created successfully"
}
```

### curl Example
```bash
curl -X POST http://<your-domain>/api/zones/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Token <your_token>" \
  -d '{
    "name": "New Zone",
    "description": "Description",
    "status": "unsafe",
    "coordinates": {"type":"Polygon","coordinates":[[[38,34],[39,34],[39,35],[38,35],[38,34]]]},
    "shape_type":"polygon"
  }'
```

---

## 3. Zone Details
- **Method:** `GET`
- **URL:** `/api/zones/<id>/`

### Sample Response
```json
{
  "id": 1,
  "name": "Zone 1",
  "description": "Description",
  "status": "unsafe",
  "status_display": "Unsafe Zone",
  "coordinates": { "..." },
  "shape_type": "polygon",
  "shape_radius": null,
  "estimated_area": 1.5,
  "notes": "...",
  "created_by": "admin",
  "created_at": "2026-04-14T12:00:00",
  "updated_by": null,
  "updated_at": "2026-04-14T12:00:00",
  "reports": [
    { "id": 10, "report_type": "mine_found", "description": "...", "created_at": "2026-04-14T12:10:00" }
  ]
}
```

---

## 4. Edit a Zone
- **Method:** `PUT`
- **URL:** `/api/zones/<id>/`
- **Content-Type:** `application/json`

### Note
This operation is protected and requires an Admin user token.

### Partial Request Body
```json
{
  "name": "Updated Name",
  "status": "safe",
  "notes": "Updated successfully"
}
```

### Success Response
```json
{
  "success": true,
  "message": "Zone updated successfully"
}
```

### curl Example
```bash
curl -X PUT http://<your-domain>/api/zones/1/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Token <your_token>" \
  -d '{"status":"safe","notes":"Updated successfully"}'
```

---

## 5. Delete a Zone
- **Method:** `DELETE`
- **URL:** `/api/zones/<id>/`

### Note
This operation is protected and requires an Admin user token.

### Success Response
```json
{
  "success": true,
  "message": "Zone 1 deleted successfully"
}
```

### curl Example
```bash
curl -X DELETE http://<your-domain>/api/zones/1/ \
  -H "Authorization: Token <your_token>"
```

---

## 6. Add a Report to a Zone
- **Method:** `POST`
- **URL:** `/api/zones/<id>/reports/`
- **Content-Type:** `application/json`

### Note
This operation is protected and requires an Admin user token.

### Request Body
```json
{
  "report_type": "mine_found",
  "description": "A mine was found here"
}
```

### Success Response
```json
{
  "success": true,
  "report_id": 12,
  "message": "Report added successfully"
}
```

### curl Example
```bash
curl -X POST http://<your-domain>/api/zones/1/reports/ \
  -H "Content-Type: application/json" \
  -H "Authorization: Token <your_token>" \
  -d '{"report_type":"mine_found","description":"Report description"}'
```

---

## 7. Get Visitor Reports
- **Method:** `GET`
- **URL:** `/api/visitor-reports/`

### Note
This operation is protected and requires an Admin user token.

### Sample Response
```json
{
  "reports": [
    {
      "id": 3,
      "full_name": "Ahmed Ali",
      "phone": "0999999999",
      "coordinates": [34.5, 39.0],
      "image": null,
      "image_url": null,
      "notes": "Mine location behind the wall",
      "confirmed": false,
      "created_at": "2026-04-14T12:30:00"
    }
  ]
}
```

### Usage Example
```javascript
fetch('/api/visitor-reports/', {
  headers: {
    'Authorization': 'Token <your_token>'
  }
})
  .then(res => res.json())
  .then(data => console.log(data));
```

---

## 8. Submit a Visitor Report
- **Method:** `POST`
- **URL:** `/api/visitor-reports/`
- **Content-Type:** `multipart/form-data`

### Note
Any visitor can submit a report without a token.

### Required Fields
- `full_name`: Full Name
- `phone`: Phone Number
- `coordinates`: Must send two elements in the array `[latitude, longitude]`
- `notes`: Report text (optional)
- `image`: Photo (optional)

### curl Example (without image)
```bash
curl -X POST http://<your-domain>/api/visitor-reports/ \
  -F "full_name=Ahmed Ali" \
  -F "phone=0999999999" \
  -F "coordinates=34.5" \
  -F "coordinates=39.0" \
  -F "notes=Mine location here"
```

### curl Example (with image)
```bash
curl -X POST http://<your-domain>/api/visitor-reports/ \
  -F "full_name=Ahmed Ali" \
  -F "phone=0999999999" \
  -F "coordinates=34.5" \
  -F "coordinates=39.0" \
  -F "notes=Mine location here" \
  -F "image=@/path/to/photo.jpg"
```

### Success Response
```json
{
  "success": true,
  "report_id": 5,
  "message": "Report submitted successfully"
}
```

---

## 9. Visitor Report Details
- **Method:** `GET`
- **URL:** `/api/visitor-reports/<id>/`

### Note
This operation is protected and requires an Admin user token.

### Sample Response
```json
{
  "id": 3,
  "full_name": "Ahmed Ali",
  "phone": "0999999999",
  "coordinates": [34.5, 39.0],
  "image": null,
  "image_url": null,
  "notes": "Mine location behind the wall",
  "confirmed": false,
  "created_at": "2026-04-14T12:30:00"
}
```

---

## 10. Delete a Visitor Report
- **Method:** `DELETE`
- **URL:** `/api/visitor-reports/<id>/`

### Note
This operation is protected and requires an Admin user token.

### Success Response
```json
{
  "success": true,
  "message": "Report deleted successfully"
}
```

### curl Example
```bash
curl -X DELETE http://<your-domain>/api/visitor-reports/3/ \
  -H "Authorization: Token <your_token>"
```

---

## 11. Confirm a Visitor Report
- **Method:** `POST`
- **URL:** `/api/visitor-reports/<id>/confirm/`

### Note
This operation is protected and requires an Admin user token.

### Success Response
```json
{
  "success": true,
  "message": "Report confirmed as a mine"
}
```

---

## 12. General Statistics
- **Method:** `GET`
- **URL:** `/api/statistics/`

### Sample Response
```json
{
  "total_zones": 10,
  "safe_zones": 4,
  "unsafe_zones": 5,
  "unknown_zones": 1,
  "total_mines": 8,
  "total_reports": 15,
  "visitor_reports": 7
}
```

---

## 13. Mine Types
- **Method:** `GET`
- **URL:** `/api/mine-types/`

### Sample Response
```json
{
  "mine_types": [
    { "id": 1, "name": "anti_personnel", "description": "Anti-personnel mine" },
    { "id": 2, "name": "anti_tank", "description": "Anti-tank mine" }
  ]
}
```

---

## General Notes
* All API paths start with `/api/`.
* `POST /api/login/` provides an authentication token.
* Use the header `Authorization: Token <your_token>` for protected requests.
* `POST /api/visitor-reports/` accepts image uploads via `multipart/form-data`.
* Coordinates can be sent as an array `[latitude, longitude]` in report requests.
* Public access is allowed for:
    * `/api/zones/` (GET)
    * `/api/zones/<id>/` (GET)
    * `/api/statistics/` (GET)
    * `/api/mine-types/` (GET)
    * `/api/visitor-reports/` (POST)
* All other routes require an Admin user token.