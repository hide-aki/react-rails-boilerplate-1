import "./flavor-form.css";
import React from "react";

class FlavorForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { value: "" };

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    console.log(this.props.name);
  }

  handleChange(event) {
    console.log(event.target.value);

    this.setState({ value: event.target.value });
  }

  handleSubmit(event) {
    alert("Your favorite flavor is: " + this.state.value);
    event.preventDefault();
  }

  render() {
    let options = this.props.messages.map(row => {
      return (
        <option key={row.id} value={row.id}>
          {row.text}
        </option>
      );
    });

    return (
      <select
        name={this.props.name}
        value={this.state.value}
        onChange={this.handleChange}
      >
        {options}
      </select>
    );
  }
}

export default FlavorForm;
