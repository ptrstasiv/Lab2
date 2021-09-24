#include <iostream>
#include <cmath>

struct Vector2D
{
	float x;
	float y;

	inline Vector2D(const float _x = 0.0f, const float _y = 0.0f)
		: x(_x), y(_y) {}

	inline Vector2D operator - (const Vector2D& v) const
	{
		return { x - v.x, y - v.y };
	}

	inline float Length() const
	{
		return sqrt(x * x + y * y);
	}
};

struct Triangle
{
	Vector2D Point1;
	Vector2D Point2;
	Vector2D Point3;

	inline Triangle(const Vector2D& p1, const Vector2D& p2, const Vector2D& p3)
		: Point1(p1), Point2(p2), Point3(p3) {}

	inline float GetArea() const
	{
		float side1 = (Point2 - Point1).Length();
		float side2 = (Point3 - Point1).Length();
		float side3 = (Point3 - Point2).Length();

		float p = (side1 + side2 + side3) * 0.5f;

		return sqrt(p * (p - side1) * (p - side2) * (p - side3));
	}

	inline Vector2D ComputeBarycentricCoordinates(const Vector2D& p)
	{
		Triangle t1(Point3, Point1, p);
		Triangle t2(Point1, Point2, p);

		float u = t1.GetArea() / GetArea();
		float v = t2.GetArea() / GetArea();

		return { u, v };
	}
};

int main()
{
	float x, y;

	std::cout << "Triangle 1 point coordinates: ";
	std::cin >> x >> y;

	Vector2D p1(x, y);


	std::cout << "\nTriangle 2 point coordinates: ";
	std::cin >> x >> y;

	Vector2D p2(x, y);


	std::cout << "\nTriangle 3 point coordinates: ";
	std::cin >> x >> y;

	Vector2D p3(x, y);

	while (1)
	{
		Triangle userTrig(p1, p2, p3);


		std::cout << "\nTest point coordinates: ";
		std::cin >> x >> y;

		Vector2D testP(x, y);


		auto barycentricP = userTrig.ComputeBarycentricCoordinates(testP);

		if (barycentricP.x >= 0.0f && barycentricP.y >= 0.0f &&
			(barycentricP.x + barycentricP.y) <= 1.0f)
		{
			float thirdCoord = 1.0f - (barycentricP.x + barycentricP.y);

			if (barycentricP.x == 1.0f || barycentricP.y == 1.0f || thirdCoord == 1.0f)
				std::cout << "\nPoint on the triangle vertex!\n";
			else if (barycentricP.x == 0.0f || barycentricP.y == 0.0f || thirdCoord == 0.0f)
				std::cout << "\nPoint on the triangle side!\n";
			else
				std::cout << "\nPoint inside triangle!\n";
		}
		else
			std::cout << "\nPoint lies outside of the triangle!\n";

		std::cout << "\n" << barycentricP.x << " " << barycentricP.y << std::endl;
	}

	return 0;
}